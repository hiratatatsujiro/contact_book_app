# README

## アプリケーション名
 
「楽ちょ〜電子連絡帳〜」

## アプリケーション概
 
学校現場における教師と児童の様々なやりとりを可能にします。 \
・出欠早退遅刻の連絡 \
・日記のやりとり \
・学級のおたより作成掲載 \
・時間わりの作成閲覧 \
・保護者間でのチャットやDM \
・不用品の売買など

## URL
35.75.106.72
 
## テスト用アカウント

教師用アカウント メールアドレス：sensei@gmail.com パスワード：111aaa  
\
児童１アカウント メールアドレス：kodomo1@gmail.com パスワード：111aaa 
\
児童２アカウント メールアドレス：kodomo2@gmail.com パスワード：111aaa 
 
## 利用方法
 
### 教師
連絡：児童が送信した欠席や遅刻などの連絡を見ることができます。\
日記：児童が送信した日記を読み、コメントすることができます。\
学級通信：学級の様子を書いたお便りを作成できます。（教師のみ作成可）

### 児童
連絡：欠席や遅刻などの連絡をすることができます。\
日記：児童が投稿した日記に対し、コメントすることができます。（他の児童は見ることはできません。）\
学級通信：学級の様子を書いたお便りを見ることができ、「いいね」することができます。

### 共通
時間わり：時間わりを作成し、見ることができます。\
チャットルーム：楽ちょに登録した全ての人と複数人のチャットができます。\
フリーマーケット：楽ちょに登録した全ての人が商品の登録・売買ができます。

# 目指した課題解決
教師は多忙な中、紙媒体の連絡帳に目を通し、コメントしたり、保護者の連絡に返事をしたりしています。また、時間わりを書かせたり、来ていない児童に連絡をしたり、お便りを作り、紙で何枚も印刷することも多いです。連絡帳は紙媒体ですので、児童が登校している間にそれらを済ませななければなりません。そんな状況を少しでも改善するため、このアプリケーションを作りました。このアプリケーションを利用すれば、上に書いていることが改善されます。
また、保護者や子どもにとっても簡単に手間なく利用でき流ものとなっています。学校での物品を無くしてそのままになっている子もいれば、保護者同士でやりとりをするとき、保護者間で連絡先を知らず、困るケースも多いです。物品を探すにはフリーマーケットを利用し購入したり、電話番号を知らない保護者同士の連絡はチャット機能を利用したりすることができます。

# 洗い出した要件定義
[![Image from Gyazo](https://i.gyazo.com/9bd2587dcaa95a3fb114f31ec3f1ff37.png)](https://gyazo.com/9bd2587dcaa95a3fb114f31ec3f1ff37)

# 実装した機能についての画像やGIFおよびその説明
ホーム画面からページを選びます。
[![Image from Gyazo](https://i.gyazo.com/7db0b0484f5a523ecae49251279ab513.gif)](https://gyazo.com/7db0b0484f5a523ecae49251279ab513)

連絡したい情報を入力し、送信します。一覧画面では児童には日付が表示され、教師には日付と名前が表示されます。
[![Image from Gyazo](https://i.gyazo.com/0cd1373fdd2498998cfaf2c57b21dded.gif)](https://gyazo.com/0cd1373fdd2498998cfaf2c57b21dded)
[![Image from Gyazo](https://i.gyazo.com/4e60a22f3d02f7723600452f57ecf729.png)](https://gyazo.com/4e60a22f3d02f7723600452f57ecf729)

日記も必要情報を入力の上、送信すると一覧に表示されます。
[![Image from Gyazo](https://i.gyazo.com/9139e477c40580066424e857daf12fdd.gif)](https://gyazo.com/9139e477c40580066424e857daf12fdd)
[![Image from Gyazo](https://i.gyazo.com/e08ece22d2dcb92b7750b96cd40df151.png)](https://gyazo.com/e08ece22d2dcb92b7750b96cd40df151)

日記詳細画面では教師とコメントのやりとりができます。
[![Image from Gyazo](https://i.gyazo.com/8f5dbe93a6c4de941a6ac85e6af76425.gif)](https://gyazo.com/8f5dbe93a6c4de941a6ac85e6af76425)
[![Image from Gyazo](https://i.gyazo.com/273e5c5fb4bc222cbbf90186eea2c290.gif)](https://gyazo.com/273e5c5fb4bc222cbbf90186eea2c290)

学級通信も日記と同様に必要事項を入力して作成でき、学級の子どもたちは閲覧できます。ただし、作成できるのは教師のみです。また、学級通信に「いいね」することができます。
[![Image from Gyazo](https://i.gyazo.com/bea4a8d98bb9a3048d7ef5789b306b18.gif)](https://gyazo.com/bea4a8d98bb9a3048d7ef5789b306b18)


チャットルームはルーム名とチャットメンバーを入力し、作成できます。
[![Image from Gyazo](https://i.gyazo.com/f1635485c1690d5ca17d949c544ceec6.gif)](https://gyazo.com/f1635485c1690d5ca17d949c544ceec6)

チャットではメンバーに画像とテキストを送信できます。
[![Image from Gyazo](https://i.gyazo.com/7671b6f581415a4bb92591d3fc6de0a1.gif)](https://gyazo.com/7671b6f581415a4bb92591d3fc6de0a1)

時間わり昨日も登録、閲覧ができます。

フリーマーケットでは、商品の登録・購入ができます。
[![Image from Gyazo](https://i.gyazo.com/be79544c2e8d6bfd9e3171b1106d5692.gif)](https://gyazo.com/be79544c2e8d6bfd9e3171b1106d5692)
[![Image from Gyazo](https://i.gyazo.com/281dbb4eed802117bd021290a0021a52.gif)](https://gyazo.com/281dbb4eed802117bd021290a0021a52)

# 実装予定の機能
CICDパイプラインの構築を行っていく予定です。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/9d430168c138ed1c63062964169c0bf9.png)](https://gyazo.com/9d430168c138ed1c63062964169c0bf9)

# ローカルでの動作方法
% git clone https://github.com/hiratatatsujiro/contact_book_app \
% cd contact_book_app \
% bundle install \
% yarn install \
% rails db:create \
% rails db:migrate \
% rails s \

ruby 2.6.5 \
ruby on rails 6.0.0 \
mysql  5.6.51 


# contact_book_app

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
- has_many :chat_messages
- has_many :room_users
- has_many :items
- has_many :orders
- has_many :class_communications
- has_many :likes
- has_many :timetables
- has_many :contacts
- has_many :item_comments

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

## comments
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| comment            | string     | null: false       |          
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
- has_many :chat_messages, dependent: :destroy

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
- has_many :item_comments

## item_comments
| Column             | Type       | Options           |
|--------------------|------------|-------------------|
| comment            | string     | null: false       |          
| user               | references | foreign_key: true |
| item               | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

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
