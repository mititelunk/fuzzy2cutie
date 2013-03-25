#ifndef TEN_GLOBAL_H
#define TEN_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(TEN_LIBRARY)
#  define TENSHARED_EXPORT Q_DECL_EXPORT
#else
#  define TENSHARED_EXPORT Q_DECL_IMPORT
#endif

#endif // TEN_GLOBAL_H
