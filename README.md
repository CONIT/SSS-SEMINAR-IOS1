
Licensed under the Apache License, Version 2.0 


[概要]  
これは株式会社コニットが提供するSamurai Purchaseを利用したサンプルアプリです。  
ライセンスはApache License2.0です。  
コードの改変、再配布は自由ですが、その上でSamurai Purchaseの機能を利用するには一定の手順を踏む必要があります。  
詳しくは下記[コードの改変について]を御覧ください。  

[コードの改変について]  
1.Samurai Purchaseを利用する前提のアプリとなります。Samurai Purchaseに申し込みをしてください。( http://www.conit.jp/ )  
2.Samurai Purchaseにアプリケーションを登録してください。登録時にアクセストークンとAPIサーバーホスト名が割り振られます。  
3.割り振られた値を使用してアプリケーションを改修します。
   Samurai Purchaseを使用するのに必要な情報をプログラム上に定義します。  
　アクセストークンは、Define.h の25行目のTOKENに定義してください。  
　サーバーホスト名は、Define.h の23行目のBASE_URLに定義してください。  
4.画面左のメニューよりSamurai Purchase＞プロダクト一覧と選択して、「新規プロダクトを登録する」からコンテンツの情報を登録して下さい。  
　※無料コンテンツを登録したい場合には、必ず「無料プロダクト」にチェックを入れて下さい。この項目は後から変更することができないためです。  
5.コンテンツ情報の登録後、「ファイル情報の更新」よりコンテンツの本体となるhtmlファイルを登録して下さい。  
　書籍ビューワーはhtmlファイルをWebViewで読み込み、表示しています。そのためビューワーを表示させるためにはhtmlファイルを登録する必要があります。  
　※このサンプルアプリは1プロダクトに関連付けされるファイルは1つのみを想定した作りとなっています。  
　　Samurai Purchaseのパッケージ機能やメタ情報機能を利用したい場合には別途アプリ側で対応が必要となりますので、  
　　開発者ドキュメント( http://sss-developer.conit.jp/index.html )のWebAPI＞リクエスト例などを参考に対応してください。  
6.コンテンツおよびその情報の登録が完了したら、各コンテンツにチェックを入れて「公開/非公開」のプルダウンリストから「選択したものを公開する」を選択、実行して下さい。  
  
ここまでの手順で、Samurai Purchaseに登録したプロダクト一覧が取得できるようになります。  
Samurai PurchaseとiTunes Connectと連携し、課金処理を確認するには以下の手順が必要となります。  
  
7.iTunes Connectからアプリケーションのアップロードを行なって下さい。  
8.iTunes ConnectからIn-App Purchaseを追加してください。  
　その際、In-App Purchaseの「Product ID」にSamurai Purchaseに登録されている「プロダクトID」と同一のIDを登録して、互いの紐付けを行なって下さい。  
  
注）動作確認をする際に、iTunes Connectでテストアカウントの追加を忘れないようにして下さい。  
  
    
[使用上の注意事項]  
・アプリは十分にテストをしていますが、お使いの端末の環境や、プログラムの不具合などによって問題が生じる可能性があります。  
　これによって生じた、いかなる損害に対しても保証は出来かねますので、あらかじめご了承ください。  
  
[関連リンク]  
・Samuri Smartphone Services  http://www.conit.jp/  
・開発者ドキュメント  http://sss-developer.conit.jp/index.html#  
・株式会社コニット  http://www.conit.co.jp/  
・Blog  http://www.conit.co.jp/conitlabs/  
・Facebook  https://www.facebook.com/conit.fan  
・Twitter  https://twitter.com/#!/conit  
_  