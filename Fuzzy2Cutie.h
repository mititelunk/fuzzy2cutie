#ifndef FUZZY2CUTIE_H
#define FUZZY2CUTIE_H

#include <string.h>
#include <postgres.h>
#include <fmgr.h>

#include "ten_global.h"

class TENSHARED_EXPORT Fuzzy2Cutie
{
public:
    Fuzzy2Cutie();
};

extern "C"
{
    #ifdef PG_MODULE_MAGIC
    PG_MODULE_MAGIC;
    #endif

    /* base: transactions.
    * fields: sum, risk.
    * ling_vars: sum, risk.
    * terms:  low, medium, high.
    */

    //
    PG_FUNCTION_INFO_V1(FuzzyInitFclFile);

    Datum
    FuzzyInitFclFile(PG_FUNCTION_ARGS)
    {
        text   arg = PG_GETARG_TEXT(0);

        PG_RETURN_TEXT(arg + 1);
    }
    //
    PG_FUNCTION_INFO_V1(FuzzyEqualMean);

    Datum
    FuzzyEqualMean(PG_FUNCTION_ARGS)
    {
        int32   arg = PG_GETARG_INT32(0);

        PG_RETURN_INT32(arg + 2);
    }
}

#endif // FUZZY2CUTIE_H
