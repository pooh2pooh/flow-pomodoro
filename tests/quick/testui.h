/*
  This file is part of Flow.

  Copyright (C) 2015 Sérgio Martins <iamsergio@gmail.com>

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef TEST_UI_H
#define TEST_UI_H

#include "testbase.h"
#include <QObject>

class QQuickItem;
class TestUI : public TestBase
{
    Q_OBJECT
public:
    explicit TestUI();

private:
    void gotoLater();
    void gotoToday();
    void expandFlow();
    void expectedTodayTasks(int num);
    void expectedArchivedTasks(int num);
    void newTask();

private Q_SLOTS:
    void initTestCase();
    void cleanupTestCase();
    void testQueueSwitchButton();
    void testGoToConfigurePage();
    void testGoToAboutPage();
    void testNewTask();
    void testArchiveTask();
    void testPlayTask();
    void testKeyBindings();
    void testShowMenuAfterAddTask();
    void testAddUntaggedBug();
    void testEnterDismissMenu();
private:
    QQuickItem *m_archiveView;
    QQuickItem *m_stagedView;
};

#endif