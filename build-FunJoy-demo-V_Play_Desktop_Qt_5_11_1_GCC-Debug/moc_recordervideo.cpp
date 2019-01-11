/****************************************************************************
** Meta object code from reading C++ file 'recordervideo.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.11.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../FunJoy-demo/recordervideo.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'recordervideo.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.11.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_RecorderVideo_t {
    QByteArrayData data[12];
    char stringdata0[141];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_RecorderVideo_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_RecorderVideo_t qt_meta_stringdata_RecorderVideo = {
    {
QT_MOC_LITERAL(0, 0, 13), // "RecorderVideo"
QT_MOC_LITERAL(1, 14, 15), // "fileNameChanged"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 11), // "isAvailable"
QT_MOC_LITERAL(4, 43, 11), // "startRecord"
QT_MOC_LITERAL(5, 55, 11), // "pasueRecord"
QT_MOC_LITERAL(6, 67, 10), // "openCamera"
QT_MOC_LITERAL(7, 78, 11), // "closeCamera"
QT_MOC_LITERAL(8, 90, 10), // "stopRecord"
QT_MOC_LITERAL(9, 101, 12), // "recoderState"
QT_MOC_LITERAL(10, 114, 15), // "currentLocation"
QT_MOC_LITERAL(11, 130, 10) // "m_fileName"

    },
    "RecorderVideo\0fileNameChanged\0\0"
    "isAvailable\0startRecord\0pasueRecord\0"
    "openCamera\0closeCamera\0stopRecord\0"
    "recoderState\0currentLocation\0m_fileName"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_RecorderVideo[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       1,   68, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   59,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       3,    0,   60,    2, 0x02 /* Public */,
       4,    0,   61,    2, 0x02 /* Public */,
       5,    0,   62,    2, 0x02 /* Public */,
       6,    0,   63,    2, 0x02 /* Public */,
       7,    0,   64,    2, 0x02 /* Public */,
       8,    0,   65,    2, 0x02 /* Public */,
       9,    0,   66,    2, 0x02 /* Public */,
      10,    0,   67,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString,

 // properties: name, type, flags
      11, QMetaType::QString, 0x00495003,

 // properties: notify_signal_id
       0,

       0        // eod
};

void RecorderVideo::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        RecorderVideo *_t = static_cast<RecorderVideo *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->fileNameChanged(); break;
        case 1: { bool _r = _t->isAvailable();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 2: _t->startRecord(); break;
        case 3: _t->pasueRecord(); break;
        case 4: _t->openCamera(); break;
        case 5: _t->closeCamera(); break;
        case 6: _t->stopRecord(); break;
        case 7: { int _r = _t->recoderState();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 8: { QString _r = _t->currentLocation();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (RecorderVideo::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&RecorderVideo::fileNameChanged)) {
                *result = 0;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        RecorderVideo *_t = static_cast<RecorderVideo *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->fileName(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        RecorderVideo *_t = static_cast<RecorderVideo *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setFileName(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject RecorderVideo::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_RecorderVideo.data,
      qt_meta_data_RecorderVideo,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *RecorderVideo::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *RecorderVideo::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_RecorderVideo.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int RecorderVideo::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void RecorderVideo::fileNameChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
