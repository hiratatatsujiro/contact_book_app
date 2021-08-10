# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計
## usersテーブル
| Column             | Type    | Options     |
|--------------------|---------|-------------|
| nickname           | string  | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_name_reading  | string  | null: false |
| first_name_reading | string  | null: false |
| grade_id           | integer | null: false |
| classroom_id       | integer | null: false |
| number_id          | integer | null: false |
| birthday           | date    | null: false |
| introduction       | string  | null: false | 

### Association
- has_many :diaries
- has_many :comments
- has_many :rooms, through :room_user
- has_many :messages
- has_many :room_users
- has_many :items
- has_many :orders
- has_many :class_communications
- has_many :likes
- has_many :timetables
- has_many :items
- has_many :orders
- has_many :class_communications
- has_many :likes
- has_many :timetables
- has_many :contacts

## diariesテーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| diary_day          | date       | null: false       |
| title              | string     | null: false       |
| diary              | text       | null: false       |
| user               | references | foreign_key: true |

### Association
- has_many :comments, dependent: :destroy
- belongs_to :user
- has_many :tag_relationships, dependent: :destroy
- has_many :tags, through: :tag_relationship

## tagsテーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| name               | string     | null: false       |

### Association
- has_many :tag_relationships, dependent: :destroy
- has_many :diaries, through: :tag_relationship

## tag_relationshipテーブル
| Column    | Type       | Options                        |
|-----------|------------|--------------------------------|
| diary     | references | null: false, foreign_kye: true |
| tag       | references | null: false, foreign_kye: true |

### Association
- belongs_to :diary
- belongs_to :tag

## diary_comments
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| user               | references | foreign_key: true |
| diary              | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :diary

## roomsテーブル
| Column    | Type     | Options     |
|-----------|----------|-------------|
| name      | string   | null: false |

### Association
- has_many :users, through :room_user
- has_many :room_users, dependent: :destroy
- has_many :messages, dependent: :destroy

## chat_messagesテーブル
| Column    | Type       | Options                        |
|-----------|------------|--------------------------------|
| content   | string     |                                |
| user      | references | null: false, foreign_kye: true |
| room      | references | null: false, foreign_kye: true |

### Association
- belongs_to :user
- belongs_to :room

## room_usersテーブル
| Column    | Type       | Options                        |
|-----------|------------|--------------------------------|
| user      | references | null: false, foreign_kye: true |
| room      | references | null: false, foreign_kye: true |

### Association
- belongs_to :user
- belongs_to :room

## itemsテーブル
| Column              | Type       | Options           |
|---------------------|------------|-------------------|
| name                | string     | null: false       |
| item_introduction   | text       | null: false       |
| category_id         | integer    | null: false       |
| grade_id            | integer    | null: false       |
| size_id             | integer    | null: false       |
| status_id           | integer    | null: false       |
| pay_for_shopping_id | integer    | null: false       |
| delivery_area_id    | integer    | null: false       |
| day_to_ship_id      | integer    | null: false       |
| price               | integer    | null: false       |
| user                | references | foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| user               | references | foreign_key: true |
| item               | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :information

## informationsテーブル
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| postal_code        | string     | null: false       |
| delivery_area_id   | integer    | null: false       |
| city               | string     | null: false       |
| house_number       | string     | null: false       |
| building           | string     |                   |
| phone_number       | string     | null: false       |
| order              | references | foreign_key: true | 

### Association
- belongs_to :order

## class_communicationsテーブル
| Column                  | Type       | Options           |
|-------------------------|------------|-------------------|
| class_communication_day | date       | null: false       |
| title                   | string     | null: false       |
| text                    | text       | null: false       |
| user                    | references | foreign_key: true |

### Association
- belongs_to :user
- has_many :likes, dependent: :destroy

## likesテーブル
| Column              | Type       | Options           |
|---------------------|------------|-------------------|
| user                | references | foreign_key: true |
| class_communication | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :class_communication 

## timetablesテーブル
| Column              | Type        | Options           |
|---------------------|-------------|-------------------|
| next_day            | date        | null: false       |
| first_class_id      | integer     | null: false       |
| second_class_id     | integer     | null: false       |
| third_class_id      | integer     | null: false       |
| fourth_class_id     | integer     | null: false       |
| fifth_class_id      | integer     | null: false       |
| sixth_class_id      | integer     | null: false       |
| homework            | string      | null: false       |
| preparation         | string      | null: false       |
| leave_time          | string      | null: false       |
| notice              | text        |                   |
| user                | references  | foreign_key: true |

### Association
- belongs_to :user

## contactsテーブル
| Column              | Type        | Options           |
|---------------------|-------------|-------------------|
| condition_id        | integer     |                   |
| reason              | string      |                   |
| pool_marathon_id    | integer     |                   |
| contact             | text        |                   |
| user                | references  | foreign_key: true |

### Association
- belongs_to :user
