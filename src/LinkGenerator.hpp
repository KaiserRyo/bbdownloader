/*
 * LinkGenerator.hpp
 *
 *  Created on: Sep 23, 2014
 *      Author: Thurask
 */

#ifndef LINKGENERATOR_HPP_
#define LINKGENERATOR_HPP_

#include <QtCore>

class LinkGenerator: public QObject
{
    Q_OBJECT

public:
    LinkGenerator();
    virtual ~LinkGenerator();

    public Q_SLOTS:
    QString incrementRadio(QString input);

    private:
};

#endif /* LINKGENERATOR_HPP_ */
