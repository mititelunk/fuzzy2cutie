#ifndef FUZZY2CUTIE_GLOBAL_H
#define FUZZY2CUTIE_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(FUZZY2CUTIE_LIBRARY)
#  define FUZZY2CUTIESHARED_EXPORT Q_DECL_EXPORT
#else
#  define FUZZY2CUTIESHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // FUZZY2CUTIE_GLOBAL_H
