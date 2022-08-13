<# ----------------------------------------------------------------------------------------------------------- #>
## Progmam   : JP_SafePlus
## Author    : Aerin_the_Lion
## Version   : 1.00
## 作った動機 : JavPlayerのSafeモード時、raw抽出があまりに貧弱過ぎてバンディングノイズが発生&画質劣化回避の目的のため
##
## JavPlayer v1.11b用(仕様変更がない限りはパス変更すれば使用可能)
## Safeモード時に最初にJavPlayerが動画から連番画像にする際、
## raw0, raw1, raw2...と連番を作成されるが、これを自前の画像に変更するツール

<# ----------------------------------------------------------------------------------------------------------- #>
## 変数定義
param($JPFolderPath = "G:\JavPlayer_111b", $TGfolder = "$JPFolderPath\TG")
$global:raw_nameData = @()
$global:raw_amountData = @()
[string]$previous_PSScriptRoot = Split-Path $PSScriptRoot
[string]$input_folder = "$previous_PSScriptRoot\input_frames"
[string]$output_folder = "$previous_PSScriptRoot\output_frames"

<# ----------------------------------------------------------------------------------------------------------- #>

## rawフォルダがいくつあるか検出し、raw_nameDataに入れる。
Function Get-RawFolderAmount($folder){
    #$folder内の全てのフォルダーの参照する
    Get-ChildItem -Path $folder | ForEach-Object{
        #文頭にrawがある場合に通す
        if($_ -match "^raw"){
            #raw_nameDataに配列としてraw0,raw1,raw2...と追加する。
            $global:raw_nameData += $_                          #globalで更新
        }
    }
}

## rawのフォルダから画像がどのくらいあるか確認する関数
Function Get-RawPicsAmount($folder){
    Foreach($rawName in $raw_nameData){
        [string]$raw_folder = "$folder\$rawName"
        # フォルダーではない場合（ファイル）の数をカウント
        [int]$raw_counter = (Get-ChildItem $raw_folder | Where-Object { ! $_.PsIsContainer }).Count
        #Write-Host ("raw_counter is " + "$raw_counter")
        $global:raw_amountData += @($raw_counter)
    }
}

Function Find-Input($input_folder){
    if((Get-ChildItem $input_folder | Measure-Object).count -eq 0){
        Write-Host "input_framesにファイルが見つかりません!"
        exit
    }
}

# ファイル群をoutput_frames移動させるための変数
Function Move-Files($inputF, $outputF,$amount){
    begin{}
    process{
        [string]$amount = $amount
        # $_でパイプすると何故か動かない（nullになる）　…？なぜ？ただまぁ、パイプでそのままオブジェクトが保っているらしい。
        Get-ChildItem $inputF | Sort-Object -Property Name| Select-Object -First $amount | Move-Item -Destination $outputF
    }
    end{}
}

# 移したrawフォルダ内のファイル群をリネームする変数
Function Rename-Files($path){
                                                                      #begin    #loop       #連番の設定    #連番のフォーマット演算子                 
    Get-ChildItem $path | Sort-Object -Property Name | ForEach-Object {$i = 0} { $NewName = "{0:0000}.png" -f $i; Move-Item "$path\$_" "$path\$NewName" -Force; $i++ }
}

# 自作連番をrawフォルダに移行するための変数
Function Set-Frames($inputF, $outputF){

    [int]$counter = 0
    foreach($amount in $raw_amountData){
        # rawフォルダ作成など
        [string]$rawFolder = "raw" + "$counter"
        [string]$rawFolderPath = "$outputF\$rawFolder"
        if(!(Test-Path -Path $rawFolderPath)){
            mkdir $rawFolderPath
        }
        Move-Files -inputF $inputF -outputF $rawFolderPath -amount $amount
        Rename-Files -path $rawFolderPath
        $counter += 1
    }
}


<# ----------------------------------------------------------------------------------------------------------- #>
Function Main(){
    # JP_SAfePlusを起動

    Get-RawFolderAmount $TGfolder
    Get-RawPicsAmount $TGfolder
    Find-Input $input_folder
    Set-Frames -inputF $input_folder -outputF $output_folder
}

Main