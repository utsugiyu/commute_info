Name
====

### 東京近郊　通勤情報bot (LINE ID: @624aybaw)
[![Image from Gyazo](https://i.gyazo.com/eaeea6bd98cc7b555e051fa0e971f3ec.png)](https://gyazo.com/eaeea6bd98cc7b555e051fa0e971f3ec)

## Description
通勤などで外出する前に知りたい「最高気温」「降水確率」「路線の運行情報」を指定した日時に通知します。曜日と時間を指定することで定期的に通知を受け取ることが可能です。服装の決定や傘の携帯の有無、使用する交通機関の変更などに役立ててください。(一つの登録情報に対して「行き」「帰り」の２つのタイミングで通知が来ます。「行き」は「最高気温」「降水確率」「路線の運行情報」、「帰り」は「路線の運行情報」のみの通知となっています。）

## Requirement
LINE上での通知となるので、LINEへの登録と上記公式アカウントの友達登録が事前に必要となります。

## Usage

[![Image from Gyazo](https://i.gyazo.com/1f173bc4d2e47f4c469ea639e219a7a8.png)](https://gyazo.com/1f173bc4d2e47f4c469ea639e219a7a8)
<br>
↑友達登録を完了すると、アカウントに関する説明と使用方法が送信されます。　
<br>
<br>
<br>
[![Image from Gyazo](https://i.gyazo.com/e6902cd216b74377134d358d23c2f96b.png)](https://gyazo.com/e6902cd216b74377134d358d23c2f96b)
<br>
↑「登録」とメッセージを送信すると、情報登録画面のリンクが表示されます。
<br>
<br>
<br> 
[![Image from Gyazo](https://i.gyazo.com/fd0bcf0e55f142759bff7e4f8a1664de.png)](https://gyazo.com/fd0bcf0e55f142759bff7e4f8a1664de)
<br> 
↑情報登録画面
<br>
<br>
<br>
[![Image from Gyazo](https://i.gyazo.com/7935d836b141e542cb84016e5f5bb47f.png)](https://gyazo.com/7935d836b141e542cb84016e5f5bb47f)
<br>
↑行き、帰りの指定時間にそれぞれ情報が通知されます。
<br>
<br>
<br>
[![Image from Gyazo](https://i.gyazo.com/f651c1a1ff6997237b803df835c63b9d.png)](https://gyazo.com/f651c1a1ff6997237b803df835c63b9d)
<br>
[![Image from Gyazo](https://i.gyazo.com/d6403a8ea94f2d124e641630be7410de.png)](https://gyazo.com/d6403a8ea94f2d124e641630be7410de)
<br>
↑「編集」もしくは「削除」のメッセージを送信することで、登録済み情報の一覧がリンクで表示されます。リンクを開いて編集や削除を行ってください。
<br>
<br>
<br>
[![Image from Gyazo](https://i.gyazo.com/e47a1a4532d92cbd0c3007e0d16b1c07.png)](https://gyazo.com/e47a1a4532d92cbd0c3007e0d16b1c07)
<br>
↑登録情報一覧

## APIs
<br>

* [Google Geocoding API](https://developers.google.com/maps/documentation/geocoding/start)
* [Dark Sky API](https://darksky.net/dev)
* [鉄道遅延情報のjson](https://rti-giken.jp/fhc/api/train_tetsudo/)
* [LINE Messaging API](https://developers.line.biz/ja/services/messaging-api/)

## Operating environment
<br>

* AWS (  EC2 + RDS(MySQL 5.7.22)  )
* Ruby 2.6.3
* Ruby on Rails 5.2.3

## Author
[Yu Utsugi](https://twitter.com/YuUtsugi)
