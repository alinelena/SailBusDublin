#include "sailbusdublin.h"
//#include <QUrl>

SailBusDublin::SailBusDublin(QObject *parent) :
    QObject(parent)
{
    this->settings = new QSettings("harbour-SailBusDublin", "SailBusDublin", this);
}

//bool SailBusDublin::validateUrl(QString url)
//{
 //   return QUrl(url).isValid();
//}

void SailBusDublin::setSetting(const QString &key, const QVariant &value){
    this->settings->setValue(key, value);
    this->settings->sync();
}

QVariant SailBusDublin::getSetting(const QString &key, const QVariant &defaultValue){
    this->settings->sync();
    QVariant value = this->settings->value(key, defaultValue);
    return value;
}
