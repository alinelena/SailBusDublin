#include "sailbusdublin.h"
//#include <QUrl>
#include <iostream>

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

void SailBusDublin::setSettingInList(const QString &key, const QString& value){
    QVector<QString> tmp;
    int n;
    bool alreadyIn = false;
    this->getSettingList(key, n, tmp);
    this->settings->beginWriteArray(key);
   
    for (int i = 0; i < n; ++i) {
      this->settings->setArrayIndex(i);
      this->settings->setValue("fav", tmp.at(i));
      if (tmp.at(i)==value) alreadyIn= true;
    }
    if (!alreadyIn) {
      this->settings->setArrayIndex(n);
      this->settings->setValue("fav", value);
    }
    this->settings->endArray();
    this->settings->sync();
}

void SailBusDublin::removeSettingIthList(const QString &key, const int& j){
    QVector<QString> tmp;
    int n;
    this->getSettingList(key, n, tmp);
    this->settings->remove(key);
    this->settings->beginWriteArray(key);
    for (int i = 0; i < n; ++i) {
      if ( i < j ) {
        this->settings->setArrayIndex(i);
      }
      if ( i > j ) {
        this->settings->setArrayIndex(i-1);
      }
      this->settings->setValue("fav", tmp.at(i));
    }
    this->settings->endArray();
    this->settings->sync();
}

QVariant SailBusDublin::getSetting(const QString &key, const QVariant &defaultValue){
    this->settings->sync();
    QVariant value = this->settings->value(key, defaultValue);
    return value;
}

int SailBusDublin::getSettingNList(const QString &key){
    this->settings->sync();
    int n = this->settings->beginReadArray(key);
    this->settings->endArray();
    return n;
}

QString SailBusDublin::getSettingIthList(const QString &key, const int &j){
    this->settings->sync();
    int n = this->settings->beginReadArray(key);
    for (int i = 0; i < n; ++i) {
      this->settings->setArrayIndex(i);
      QString val=this->settings->value("fav").toString();
      if (i==j){
        this->settings->endArray();
        return val;
      }
    }
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
