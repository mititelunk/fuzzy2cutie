#ifndef FUZZY2CUTIE_H
#define FUZZY2CUTIE_H

#include <string.h>


#include <jfuzzyqt.h>
#include <iostream>

#include "fuzzy2cutie_global.h"

extern "C" {
#include <postgres.h>
#include <fmgr.h>

    #ifdef PG_MODULE_MAGIC
    PG_MODULE_MAGIC;
    #endif
}

class FUZZY2CUTIESHARED_EXPORT Fuzzy2Cutie
{
    jfuzzyqt::JFuzzyQt *model;
public:
    Fuzzy2Cutie();
    // SELECT FuzzyInitFclFile('../fuzzy2cutie/risk_card.fcl');
    bool FuzzyInitFclFile(const char* fileName)
    {
        if(model != NULL)
            delete model;
        model = new jfuzzyqt::JFuzzyQt();
        if(!model->load(fileName))
        {
            delete model;
            model = NULL;
            return false;
        }
        return true;
    }
    double FuzzyEvaluateValue(const char* inputs, const char* output)
    {
        if(model==NULL)
        {
            std::cerr << "Error Executing FuzzyEqualMean without model" << std::endl;
            return 0.;
        }
        QString funct_block;
        QStringList qInputs = QString::fromLocal8Bit(inputs).split(",");
        QString qOutput = QString::fromLocal8Bit(output).trimmed();
        for(uint i = 0; i < (uint)qInputs.size(); i++)
        {
            QStringList pair = qInputs.at(i).split("=");
            model->setVariable(pair.at(0).trimmed(),pair.at(1).trimmed().toDouble());
        }
        model->evaluate();
        return model->getValue(qOutput);
    }
};

static Fuzzy2Cutie fuzzy2Cutie = Fuzzy2Cutie();

extern "C"
{
    //
    PG_FUNCTION_INFO_V1(FuzzyInitFclFile);

    Datum
    FuzzyInitFclFile(PG_FUNCTION_ARGS);
    //
    PG_FUNCTION_INFO_V1(FuzzyEvaluateValue);

    Datum
    FuzzyEvaluateValue(PG_FUNCTION_ARGS);
}

Datum
FuzzyInitFclFile(PG_FUNCTION_ARGS)
{
    text *t=PG_GETARG_TEXT_P(0);
    char *fileName=new char[VARSIZE(t)-VARHDRSZ+1];
    memcpy((void *)fileName,(void *)VARDATA(t),VARSIZE(t)-VARHDRSZ);
    fileName[VARSIZE(t)-VARHDRSZ]=0;
    PG_RETURN_BOOL(fuzzy2Cutie.FuzzyInitFclFile(fileName));
}

Datum
FuzzyEvaluateValue(PG_FUNCTION_ARGS)
{
    text *t=PG_GETARG_TEXT_P(0);
    char *inputs=new char[VARSIZE(t)-VARHDRSZ+1];
    memcpy((void *)inputs,(void *)VARDATA(t),VARSIZE(t)-VARHDRSZ);
    inputs[VARSIZE(t)-VARHDRSZ]=0;
    t=PG_GETARG_TEXT_P(1);
    char *output=new char[VARSIZE(t)-VARHDRSZ+1];
    memcpy((void *)output,(void *)VARDATA(t),VARSIZE(t)-VARHDRSZ);
    output[VARSIZE(t)-VARHDRSZ]=0;

    PG_RETURN_FLOAT8(fuzzy2Cutie.FuzzyEvaluateValue(inputs,output));
}

#endif // FUZZY2CUTIE_H
