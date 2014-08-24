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

void SailBusDublin::setSettingListi(const QString &key, const int &i, const QString& value){

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
