#include "sailbusdublin.h"
//#include <QUrl>

SailBusDublin::SailBusDublin(QObject *parent) :
    QObject(parent)
{
    this->settings = new QSettings("harbour-sailBusDublin", "SailBusDublin", this);

}

//bool SailBusDublin::validateUrl(QString url)
//{
 //   return QUrl(url).isValid();
//}

void SailBusDublin::setSetting(const QString &key, const QVariant &value){
    this->settings->setValue(key, value);
    this->settings->sync();
}

void SailBusDublin::setSettingList(const QString &key, const QVector<QString> &array){
    this->settings->beginWriteArray(key);
    for (int i = 0; i < array.size(); ++i) {
      this->settings->setArrayIndex(i);
      this->settings->setValue("fav", array.at(i));
    }
    this->settings->endArray();
    this->settings->sync();
}

QVariant SailBusDublin::getSetting(const QString &key, const QVariant &defaultValue){
    this->settings->sync();
    QVariant value = this->settings->value(key, defaultValue);
    return value;
}

void SailBusDublin::getSettingList(const QString &key, int &n, QVector<QString> &array){
    this->settings->sync();
    n = this->settings->beginReadArray(key);
    for (int i = 0; i < n; ++i) {
      this->settings->setArrayIndex(i);
      QString val=this->settings->value("fav").toString();
      array.append(val);
    }
    this->settings->endArray();
    
}
