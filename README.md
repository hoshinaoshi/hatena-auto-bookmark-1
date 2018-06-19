# credentialについて
このディレクトリ直下に置く。中身は玉井が持っています。

# hatebu-auto-bookmark.rb
このファイルの実行時の第一引数に
- rhodia (ネットワークが玉井のスマホのとき: 但しiPhoneのインターネット共有なので、接続したいときに接続できない可能性が高いです)  
- oyasumi (ネットワークがコンテンツ本部 603HW のWiFiのとき)
- adele (ネットワークがPIXTA-GUESTのWiFiのとき)
- ellie ( ネットワークが401HW のWiFiのとき)  
のどれかを指定すると、ブクマするユーザを指定できます。

# crontabから実行
credentialsのパスを条件分岐したので、crontabから正しく実行できるようになりました。(18/6/19)
