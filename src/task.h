/*
  This file is part of Flow.

  Copyright (C) 2013-2014 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com
  Author: Sérgio Martins <sergio.martins@kdab.com>

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

#ifndef _TASK_H_
#define _TASK_H_

#include "tag.h"
#include "tagref.h"
#include "genericlistmodel.h"

#include <QString>
#include <QMetaType>
#include <QDateTime>
#include <QDataStream>
#include <QSharedPointer>

enum TaskStatus {
    TaskStopped,
    TaskPaused,
    TaskStarted
};

enum SerializerVersion {
    SerializerVersion1 = 100,
    SerializerVersion2 = 101 // Added Task::description()
};

class Storage;
class CheckableTagModel;
class QAbstractListModel;

class Task : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool staged READ staged WRITE setStaged NOTIFY stagedChanged)
    Q_PROPERTY(QString summary READ summary WRITE setSummary NOTIFY summaryChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QObject * tagModel READ tagModel CONSTANT)
    Q_PROPERTY(QObject * checkableTagModel READ checkableTagModel CONSTANT)
    // Shortcuts
    Q_PROPERTY(bool paused  READ paused  NOTIFY statusChanged STORED false)
    Q_PROPERTY(bool stopped READ stopped NOTIFY statusChanged STORED false)
    Q_PROPERTY(bool running READ running NOTIFY statusChanged STORED false)
public:
    typedef QSharedPointer<Task> Ptr;
    typedef GenericListModel<Ptr> List;

    static Task::Ptr createTask(const QString &name = QString());

    bool staged() const;
    void setStaged(bool);

    QString summary() const;
    void setSummary(const QString &text);

    QString description() const;
    void setDescription(const QString &text);

    bool containsTag(const QString &name) const;
    int indexOfTag(const QString &name) const;
    TagRef::List tags() const;
    void setTagList(const TagRef::List &);
    QAbstractItemModel *tagModel() const;
    QAbstractItemModel *checkableTagModel() const;

    Q_INVOKABLE void addTag(const QString &tagName);
    Q_INVOKABLE void removeTag(const QString &tagName);

    TaskStatus status() const;
    void setStatus(TaskStatus status);

    QDateTime creationDate() const;
    QDateTime modificationDate() const;

    bool running() const;
    bool stopped() const;
    bool paused() const;

    Task::Ptr toStrongRef() const;
    void setWeakPointer(const QWeakPointer<Task> &);

    QVariantMap toJson() const;
    static Task::Ptr fromJson(const QVariantMap &);

    int revision() const;
    int revisionOnWebDAVServer() const;
    void setRevisionOnWebDAVServer(int);

    QString uuid() const;

    bool operator==(const Task::Ptr &other) const;

Q_SIGNALS:
    void summaryChanged();
    void descriptionChanged();
    void tagsChanged();
    void statusChanged(); // not a stored property, so not connected to changed()
    void stagedChanged();
    void changed();

private Q_SLOTS:
    void onEdited();

private:
    explicit Task(const QString &name = QString());
    void setRevision(int);
    void setModificationDate(const QDateTime &);
    void setCreationDate(const QDateTime &);
    void setUuid(const QString &uuid);

    QString m_summary;
    QString m_description;
    TagRef::List m_tags;
    CheckableTagModel *m_checkableTagModel;
    TaskStatus m_status;
    bool m_staged;
    QWeakPointer<Task> m_this;
    Storage *m_storage;
    QDateTime m_creationDate;
    QDateTime m_modificationDate;
    int m_revision;
    int m_revisionOnWebDAVServer;
    mutable QString m_uuid;
};

QDataStream &operator<<(QDataStream &out, const Task::Ptr &task);
QDataStream &operator>>(QDataStream &in, Task::Ptr &task);

Q_DECLARE_METATYPE(Task::Ptr)
Q_DECLARE_METATYPE(Task::List)

#endif
