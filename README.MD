# XPlanar ちゃぶ台仕様 参考プログラム

XPlanarの2枚タイルと、ウルトラコンパクトIPCを用いた小さな磁気浮遊式搬送システムのTwinCATプロジェクトです。

## 特徴

* [ジョブ実行フレームワーク](https://github.com/Beckhoff-JP/PLC_JobManagementFramework)を用いる事で、動作ロジックと、それを使った動作パターンを切り離して実装できます。

    同じパターンの動作をファンクションブロック化し、動作パターン毎に定義したインスタンスを組み合わせてシーケンスを構築できます。

    ![](assets/2024-05-17-17-52-54.png)

* [XPlanarタイルのEtherCATのCoEのSDOによる診断情報を読み取るライブラリ](https://github.com/Beckhoff-JP/TwinCATDiagnosisTools)による診断データの取得

    XPlanarタイルのSDOには診断データとしてタイル温度や冷却ファンの速度などが取得できます。インデックス、サブインデックスを指定する事で任意のSDOの値を収集できるライブラリを用いて、診断情報を繰り返し収集するプログラムが付属しています。

## 必要ライブラリ

`bundle`フォルダに同梱している次の[ライブラリをインストール](https://beckhoff-jp.github.io/TwinCATHowTo/library/use_library.html#install-library)してください。

* JobManagement.library
* DiagnosisTools.library

## XPlanarの準備

ちゃぶ台のIPCと接続したTwinCAT XAE上にて本プロジェクトを開き、次のURL以後の手順にて、Configuratorによりbmlファイルを作成してください。作成したbmlを、マニュアルに示されている通りIPCの規定のフォルダへ配置してください。

https://beckhoff-jp.github.io/TwinCATHowTo/xplanar/configurator/index.html#id1

## 動作説明

IPCをRUNモードにし、ログイン後、PLCプロジェクトの`VISUs`フォルダ以下の`Visualization`を開きます。次の画面が現れます。

![](assets/2024-05-17-15-10-26.png)

|名称|説明|
|---|---|
|運転中|制御状態を示します。電源OFF, 原点復帰中, 運転中, サーボOFF中と表示されます。|
|Run|稼働中ランプです。点滅中にEnableボタンを押すことができます。次にDisableボタンを押すまでこのランプが点灯します。|
|Error|XPlanarのコントローラに何等かのエラーが発生した際の点灯します。解除可能な場合は、Resetボタンにて解除できます。|
|Enable|Xplanarへ電源が供給され、原点復帰に続いてデモ動作が開始されます。|
|Disable|Xplanarの電源をOFFします。|
|Reset|エラーの解除、または、Stopにより一時停止した際の動作再開時にこのボタンを押してください。|
|Stop|現在の動作を一時停止します。|
|Step/1033|Job名とJOB番号を表示します。|

Enableボタンを押すと、原点復帰動作を行い、A、B軸とも水平、Z軸は初期の浮遊位置となり、最後にC軸回転動作を行います。完了すると続いて、次のシーケンス動作を開始します。

1. 直線動作4方向
2. C軸（回転）動作
3. Z軸（上下）動作
4. A軸（前後傾き）動作
5. B軸（左右傾き）動作
6. A/B軸順次動作（前後左右）動作

## 診断機能

左右のタイルそれぞれで次の値を表示します。

1. 冷却ファン回転数（RPM）を数値と180°メータで表示します。
2. 指令回転数（デューティ比のパーセンテージ）
3. 中央、東西南北の温度計の値
4. 消費電流

## プログラミング

次の手順で、ジョブ実行フレームワークを用いた機能拡張が可能です。実装方法はこちらをご覧ください。

[https://beckhoff-jp.github.io/TwinCATHowTo/plc_object_oriented_programming/sample_universal_activity.html#id5](https://beckhoff-jp.github.io/TwinCATHowTo/plc_object_oriented_programming/sample_universal_activity.html#id5)