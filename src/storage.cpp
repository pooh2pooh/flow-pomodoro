/*
  This file is part of Flow.

  Copyright (C) 2014 Sérgio Martins <iamsergio@gmail.com>

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

#include "storage.h"
#include "tagstorageqsettings.h"
#include "taskstorageqsettings.h"

Storage::Storage(QObject *parent)
    : QObject(parent)
    , m_tagStorage(nullptr)
    , m_taskStorage(nullptr)
{
}

Storage *Storage::instance()
{
    static Storage *storage = new Storage(qApp);
    return storage;
}

TagStorage *Storage::tagStorage()
{
    if (!m_tagStorage) // due to deadlock in instance()
        m_tagStorage = new TagStorageQSettings(this);

    return m_tagStorage;
}

TaskStorage *Storage::taskStorage()
{
    if (!m_taskStorage)
        m_taskStorage = new TaskStorageQSettings(this);
    return m_taskStorage;
}