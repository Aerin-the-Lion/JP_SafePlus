# JP_SafePlus
This tool would fixes image quality problem of JavPlayer Safe Mode.<br>
<br>
to be continued to write how to use.<br>
<br>
Program   : JP_SafePlus<br>
Author    : Aerin_the_Lion<br>
Version   : 1.00<br>
作った動機 : JavPlayerのSafeモード時、raw抽出があまりに貧弱過ぎてバンディングノイズが発生&画質劣化回避の目的のため<br>
<br>
JavPlayer v1.11b用(仕様変更がない限りはパス変更すれば使用可能)<br>
Safeモード時に最初にJavPlayerが動画から連番画像にする際、<br>
raw0, raw1, raw2...と連番を作成されるが、これを自前の画像に変更するツール<br>
<br>
<br>
# How To Use
現状、JavPlayerに入れた動画の最初と最後を録画範囲にした、動画の全コマで作成したものにしか対応していません。<br>
（注意！）JavPlayerのデコーダーをMedia FoundationからDirect Showにしてください。<br>
こうしないと、コマ数が変わってJP_SafePlusで生成するコマ数と差異が生まれてしまい、バグにつながります。<br>
<br>
1.JavPlayerに動画を追加し、指定範囲を最初と最後に合わせ、いつも通りモザイク破壊した動画を作成します。<br>
2.FFmpegなどで、元動画をpng連番にしたものを自前で用意します。(FFmpegの自己用batは自分で作るか、こっちで用意しているbatを使ってください。)<br>
3.できた連番はJP_SafePlusのinput_framesに入れます。<br>
4.JP_SafePlus.batを起動。<br>
5.output_framesにJavPlayerのrawフォルダと全く同じ命名された連番がありますので、フォルダごとこれをJavPlayer/TGに放り込む。<br>
6.JavPlayerに戻り、「録画再開」→「エンコードの最初から」で劣化無しの動画作成完了です。<br>
<br>
<br>
ほぼ自分用の使い捨てスクリプトです。なにかあればissueでお伝えください。