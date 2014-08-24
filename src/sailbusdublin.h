#ifndef SAILBUSDUBLIN_H
#define SAILBUSDUBLIN_H

#include <QObject>
#include <QSettings>
#include <QString>
#include <QVector>

class SailBusDublin : public QObject
{
    Q_OBJECT

public:
    explicit SailBusDublin(QObject *parent = 0);
//    Q_INVOKABLE bool validateUrl(QString url);

private:
    QSettings *settings;

signals:

public slots:
    Q_INVOKABLE void setSetting(const QString &key, const QVariant &value);
    Q_INVOKABLE void setSettingList(const QString &key, const QVector<QString> &array);
    Q_INVOKABLE void setSettingInList(const QString &key, const QString& value);
    Q_INVOKABLE QVariant getSetting(const QString &key, const QVariant &defaultValue = QVariant());
    Q_INVOKABLE void getSettingList(const QString &key, int &n, QVector<QString> &array);
    Q_INVOKABLE int getSettingNList(const QString &key);
    Q_INVOKABLE QString getSettingIthList(const QString &key, const int &i);
    Q_INVOKABLE void removeSettingIthList(const QString &key, const int& j);
};

#endif // SAILBUSDUBLIN_H
