 
#1691391844
ls
#1691392121
curl -fsSL https://orcaterm-1258344699.cos.accelerate.myqcloud.com/linux/install.sh | bash -s -- --check
#1691392134
cd ..
#1691392136
ls
#1691392195
cd ubuntu/
#1691392196
ls
#1691392202
mkdir file
#1691392205
cd file/
#1691392209
mkdir java
#1691392215
mkdir mysql
#1691392217
cd java
#1691392224
sudo apt update
#1691392255
sudo apt install mysql-server
#1691392267
ls
#1691392269
java
#1691392295
systemctl status mysql
#1691392418
sudo mysql --password
#1691392838
ls
#1691392841
cd ..
#1691392842
cd mysql/
#1691392843
ls
#1691392890
service mysql start
#1691392901
sudo service mysql start
#1691393730
cd ..
#1691393749
mkdir mygit
#1691393751
ls
#1691393752
cd mygit/
#1691393920
git clone git@github.com:Circular-Aflame/riyu.git
#1691398086
wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
#1691398547
bash /tmp/Anaconda3-2023.07-2-Linux-x86_64.sh
#1691398705
cd /home/
#1691398708
ls
#1691398710
cd ubuntu/
#1691398710
conda create -n aligner -c conda-forge montreal-forced-aligner
#1691398711
cd h
#1691398717
cd file/
#1691398719
cd riyu/
#1691398721
ls
#1691398731
conda init
#1691398753
conda create -n aligner -c conda-forge montreal-forced-aligner
#1691398756
bash /tmp/Anaconda3-2023.07-2-Linux-x86_64.sh
#1691398776
conda init
#1691398865
source ./anaconda3/bin/activate
#1691398870
conda init
#1691398731
java -jar riyu-0.0.1-SNAPSHOT.jar 
#1691399018
ls
#1691399020
cd ..
#1691399021
ls
#1691399022
cd file/
#1691399026
cd riyu/
#1691399028
ls
#1691399050
jave -jar riyu-0.0.1-SNAPSHOT.jar 
#1691398884
conda create -n aligner -c conda-forge montreal-forced-aligner
#1691399060
conda activate aligner
#1691399061
java -jar riyu-0.0.1-SNAPSHOT.jar 
#1691399073
mfa model download dictionary japanese_mfa
#1691400443
mkdir ./clash
#1691400453
cd ./clash
#1691400463
wget https://ghproxy.com/https://github.com/Dreamacro/clash/releases/download/v1.10.6/clash-linux-amd64-v1.10.6.gz
#1691400476
gunzip -d clash-linux-amd64-v1.10.6.gz
#1691400487
chmod +x ./*
#1691400499
ls
#1691400510
wget -O config.yaml 'https://convert.szlatteart.com/sub?target=clash&url=https%3A%2F%2Fwww.sub-nthu.com%2Fapi%2Fv1%2Fclient%2Fsubscribe%3Ftoken%3D5d9883c17e5c0192e318ea3f5ddd0f04'
#1691400525
wget https://fastly.jsdelivr.net/gh/Dreamacro/maxmind-geoip@release/Country.mmdb
#1691400866
setsid ./clash-linux-amd64-v1.10.6 -d ~/clash
#1691399167
mfa model download acoustic japanese_mfa
#1691401576
export https_proxy=http://127.0.0.1:7890
#1691401580
mfa model download acoustic japanese_mfa
#1691401607
lsof -i :7890
#1691401622
kill -9 61663
#1691402094
mkdir test
#1691402098
cd test
#1691402196
mfa --single_speaker --clean ./ japanese_mfa japanese_mfa ./
#1691402219
ls
#1691402234
mfa  align--single_speaker --clean ./ japanese_mfa japanese_mfa ./
#1691402243
mfa align --single_speaker --clean ./ japanese_mfa japanese_mfa ./
#1691402558
ls
#1691402568
cd..
#1691402570
cd ..
#1691402571
ls
#1691402573
cd ..
#1691402574
ls
#1691402578
cd file/
#1691402579
ls
#1691402582
cd riyu/
#1691402583
ls
#1691402593
cd ..
#1691402596
ls
#1691402598
cd file/
#1691402599
ls
#1691402601
cd riyu/
#1691402602
ls
#1691402641
cd ..
#1691402643
ls
#1691402695
mfa align --single_speaker --clean --output_format json ./ japanese_mfa japanese_mfa ./
#1691402779
rm -rf file/
#1691402780
ls
#1691402790
cd srtmain/
#1691402791
ls
#1691402792
cd riyu/
#1691402795
ls
#1691402911
export https_proxy=http://127.0.0.1:7890
#1691402918
mfa model download acoustic japanese_mfa
#1691402940
export https_proxy=http://127.0.0.1:7890
#1691402942
mfa model download acoustic japanese_mfa
#1691402948
lsof -i :7890
#1691402984
conda init
#1691402992
lsof -i :7890
#1691403068
export https_proxy=http://127.0.0.1:7890
#1691403101
mfa model download dictionary japanese_mfa
#1691403112
mfa model download acoustic japanese_mfa
#1691403133
lsof -i :7890
#1691403142
kill -9 88557
#1691403144
lsof -i :7890
#1691403241
mfa align --single_speaker --output_format json ./ japanese_mfa japanese_mfa ./
#1691403410
cd ..
#1691403412
cd .
#1691403414
cd ..
#1691403417
cd ubuntu/
#1691403418
ls
#1691460624
curl -fsSL https://orcaterm-1258344699.cos.accelerate.myqcloud.com/linux/install-v1.0.sh | bash -s -- --check
#1691460628
cd ..
#1691460630
ls
#1691460631
cd ubuntu/
#1691460679
ls
#1691460681
cd srtmain/
#1691460682
ls
#1691460688
mkdir vosk
#1691460689
ls
#1691460691
cd vosk/
#1691460704
pip3 install vosk
#1691460763
python3 --version
#1691460868
vosk-transcriber
#1691460876
ls
#1691460880
cd ..
#1691460946
ls
#1691460954
cd test/
#1691460955
ls
#1691461050
sudo apt update
#1691461080
cd ..
#1691461083
cd srtmain/
#1691461084
ls
#1691461105
mkdir ffmpeg
#1691461106
ls
#1691461108
cd ffmpeg/
#1691461118
sudo apt install ffmpeg
#1691461260
ls
#1691461373
cd ..
#1691461375
cd vosk/
#1691461383
git clone git@github.com:alphacep/vosk-api.git
#1691461674
ls
#1691461678
cd srtmain/
#1691461680
ls
#1691461685
cd vosk/
#1691461686
ls
#1691461828
ls
#1691461832
cd vosk-api/
#1691461833
ls
#1691461842
code
#1691462264
ls
#1691462265
cd vosk-api/
#1691462267
cd python/
#1691462268
ls
#1691462276
cd example/
#1691462277
ls
#1691462331
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462400
setsid ./clash-linux-amd64-v1.10.6 -d ~/clash
#1691462427
setsid ~/clash-linux-amd64-v1.10.6 -d ~/clash
#1691462445
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691462465
export all_proxy="localhost, 127.0.0.1"
#1691462476
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462527
lsof -i :7890
#1691462563
kill -9 347295
#1691462573
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462629
ls
#1691462636
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462714
lsof -i :7890
#1691462720
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462792
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691462823
export all_proxy=http://127.0.0.1:7890
#1691462834
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462897
lsof -i :7890
#1691462922
kill -9 349070
#1691462926
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691462972
sudo apt update
#1691462981
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691463038
unset all_proxy
#1691463041
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691463133
cd ..
#1691463138
ls
#1691463144
cd ..
#1691463145
ls
#1691463146
cd ubuntu/
#1691463147
ls
#1691463150
cd srtmain/
#1691463150
ls
#1691463153
cd ..
#1691463180
code .
#1691463606
cdls
#1691463608
ls
#1691463619
cd srtmain/vosk/vosk-api/python/example/
#1691463620
ls
#1691463622
code .
#1691463767
python3 test_ffmpeg.py 2だってそうだろうが.m4a 
#1691464196
cd ..
#1691464202
cd /tmp/
#1691464204
cd ..
#1691464206
ls
#1691464211
cd home/
#1691464213
ls
#1691464216
cd ubuntu/
#1691464218
ls
#1691464219
cd test/
#1691464220
ls
#1691464225
code .
#1691464952
python mfa_reader.py 1オレンジジュースください.json 
#1691466935
cd test
#1691466937
ls
#1691466969
mfa_reader.py 1.json
#1691466977
python mfa_reader.py 1.json
#1691467371
conda activate aligner
#1691467375
mfa
#1691467553
mfa inspect japanese_mfa
#1691467566
mfa model inspect japanese_mfa
#1691467580
mfa model inspect dictionary japanese_mfa
#1691474940
curl -fsSL https://orcaterm-1258344699.cos.accelerate.myqcloud.com/linux/install-v1.0.sh | bash -s -- --check
#1691474989
ls
#1691474991
cd srtmain/
#1691474992
ls
#1691475008
mkdir praat
#1691475009
ls
#1691475010
cd praat/
#1691475047
pip install praat-parselmouth
#1691475074
python mfa_reader.py 1.json
#1691475323
cd ~/test/
#1691475324
ls
#1691475468
code .
#1691475536
cd ..
#1691475542
cd srtmain/praat/
#1691475549
python get_freq.py 
#1691475824
python mfa_reader.py 1.json
#1691475829
cd test
#1691475831
python mfa_reader.py 1.json
#1691480966
pip install nagisa
#1691481051
pip install blosc2~=2.0.0
#1691482222
conda activate aligner
#1691482272
mfa align --single_speaker --output_format json ./ japanese_mfa japanese_mfa ./
#1691482337
mfa align --single_speaker --clean --output_format json ./ japanese_mfa japanese_mfa ./
#1691482367
mfa align --single_speaker --output_format json ./ japanese_mfa japanese_mfa ./
#1691482396
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691482405
export https_proxy=http://127.0.0.1:7890
#1691482418
mfa model download dictionary japanese_mfa
#1691482433
mfa model download acoustic japanese_mfa
#1691482469
lsof -i :7890
#1691482516
kill -9 437728
#1691482578
mfa align --single_speaker --output_format json ./ japanese_mfa japanese_mfa ./
#1691482690
mfa align --output_format json ./ japanese_mfa japanese_mfa ./
#1691482911
deactive
#1691482920
conda deactivate
#1691482982
python mfa_controller.py .
#1691483403
pip install nagisa
#1691483425
import nagisa
#1691483425
text = 'Pythonで簡単に使えるツールです'
#1691483425
words = nagisa.tagging(text)
#1691483425
print(words)
#1691483425
#=> Python/名詞 で/助詞 簡単/形状詞 に/助動詞 使える/動詞 ツール/名詞 です/助動詞
#1691483425
# Get a list of words
#1691483425
print(words.words)
#1691483425
#=> ['Python', 'で', '簡単', 'に', '使える', 'ツール', 'です']
#1691483425
# Get a list of POS-tags
#1691483425
print(words.postags)
#1691483425
#=> ['名詞', '助詞', '形状詞', '助動詞', '動詞', '名詞', '助動詞']
#1691483479
python nagisa.py 
#1691483653
python cut_words.py 
#1691484520
python
#1691487116
python mfa_controller.py .
#1691489537
python mfa_controller.py .
#1691489573
whereis activate
#1691489623
cd ..
#1691489625
ls
#1691489626
cd ..
#1691489628
ls
#1691489658
cd b
#1691489661
cd bin/
#1691489662
ls
#1691489671
cd conda
#1691489673
ls
#1691489675
cd ..
#1691489680
cd home/ubuntu/
#1691489681
ls
#1691489683
cd anaconda3/
#1691489684
ls
#1691489689
cd envs/
#1691489689
ls
#1691489703
cd ..
#1691489704
ls
#1691489706
cd test/
#1691489708
ls
#1691489725
whereis activate
#1691489844
python mfa_controller.py .
#1691490332
conda activate aligner
#1691490543
python
#1691490199
python
#1691490777
python mfa_controller_copy.py .
#1691491086
python mfa_controller.py .
#1691491091
cd ~/anaconda3/etc/profile.d/
#1691491092
ls
#1691491124
conda activate aligner
#1691491157
conda deactivate
#1691491165
cd ~/test/
#1691491170
python mfa_controller_copy.py .
#1691491462
chmod +x mfa_caller.h
#1691491465
chmod +x mfa_caller.sh
#1691491469
python mfa_controller.py .
#1691492110
conda activate aligner
#1691492128
mfa align --output_format json . japanese_mfa japanese_mfa ./cache
#1691492413
mfa align --clean  --output_format json . japanese_mfa japanese_mfa ./cache
#1691492530
conda env remove -p aligner
#1691492552
conda activate aligner
#1691492562
conda activate a
#1691492570
conda info --envs
#1691492578
conda deactivate
#1691492588
conda env remove -p aligner
#1691492593
conda info --envs
#1691492595
conda env remove -p aligner
#1691492599
conda info --envs
#1691492623
conda remove -n aligner --all
#1691492641
cd .
#1691492643
cd ..
#1691492651
rm -rf Documents
#1691492652
ls
#1691545687
curl -fsSL https://orcaterm-1258344699.cos.accelerate.myqcloud.com/linux/install-v1.0.sh | bash -s -- --check
#1691545723
cd srtmain/
#1691545724
ls
#1691545734
mkdir mfa
#1691545735
ls
#1691545738
cd mfa/
#1691545740
ls
#1691545765
conda create -n aligner -c conda-forge montreal-forced-aligner
#1691545869
conda activate aligner
#1691545988
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691545995
export https_proxy=http://127.0.0.1:7890
#1691546007
mfa model download dictionary japanese_mfa
#1691546018
conda activate aligner'

#1691546032
conda activate aligner
#1691546035
mfa model download dictionary japanese_mfa
#1691546103
mfa model download acoustic japanese_mfa
#1691546119
lsof -i :7890
#1691546127
kill -9 708528
#1691546173
ls
#1691546175
cd ..
#1691546178
ls
#1691546179
cd test/
#1691546180
ls
#1691546266
mfa align  --single_speaker  --clean  . /home/ubuntu/Documents/MFA/pretrained_models/dictionary/japanese_mfa.dict /home/ubuntu/Documents/MFA/pretrained_models/acoustic/japanese_mfa.zip testout/
#1691546409
cd ..
#1691546410
ls
#1691546417
code .
#1691546555
cd Documents/
#1691546556
code .
#1691546644
cd test/
#1691546887
mfa align  --single_speaker   . /home/ubuntu/Documents/MFA/pretrained_models/dictionary/japanese_mfa.dict /home/ubuntu/Documents/MFA/pretrained_models/acoustic/japanese_mfa.zip testout/
#1691547028
conda deactive
#1691547036
conda deactivate
#1691547068
conda create -n align -c conda-forge montreal-forced-aligner
#1691547106
lsof -i :7890
#1691547132
unset https_export
#1691547136
conda create -n align -c conda-forge montreal-forced-aligner
#1691547190
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691547201
export https_proxy=http://127.0.0.1:7890
#1691547216
conda create -n align -c conda-forge montreal-forced-aligner
#1691547307
conda activate align
#1691547318
mfa model download dictionary japanese_mfa
#1691547315
mfa align  --single_speaker /home/ubuntu/test/   /home/ubuntu/Documents/MFA/pretrained_models/dictionary/japanese_mfa.dict /home/ubuntu/Documents/MFA/pretrained_models/acoustic/japanese_mfa.zip testout/
#1691547372
conda deactivate
#1691547381
conda remove -n align
#1691547382
mfa align  --single_speaker --clean   /home/ubuntu/test/   /home/ubuntu/Documents/MFA/pretrained_models/dictionary/japanese_mfa.dict /home/ubuntu/Documents/MFA/pretrained_models/acoustic/japanese_mfa.zip testout/
#1691547425
conda env remove --name align
#1691547736
python mfa_controller_copy.py /home/ubuntu/test/
#1691548352
python mfa_controller.py /home/ubuntu/test/
#1691548865
cd ./test
#1691548867
ls
#1691548927
python mfa_controller.py /home/ubuntu/test
#1691550710
python mfa_controller_copy.py  /home/ubuntu/test/
#1691552035
python mfa_controller.py /home/ubuntu/test/cache/
#1691552712
pip uninstall nagisa
#1691552735
cd ..
#1691552742
cd srtmain/
#1691552743
ls
#1691552754
mkdir pykakasi
#1691552755
ls
#1691552764
cd p
#1691552767
cd pykakasi/
#1691552770
pip install pykakasi
#1691553058
python mfa_controller.py /home/ubuntu/test/cache/
#1691553105
pip uninstall pykakasi
#1691553113
pip install pykakasi
#1691553120
python mfa_controller.py /home/ubuntu/test/cache/
#1691553839
cd..
#1691553841
cd ..
#1691553843
ls
#1691553888
git
#1691553939
cd ..
#1691554338
git init
#1691554349
conda deactivate
#1691554351
pip uninstall pykakasi
#1691554382
git add .
#1691554506
java -version
#1691554669
code .
#1691554689
git rm -r --cached .
#1691554902
git clean -f .git/index.lock
#1691556637
git rm -r --cached .
#1691556650
cd ..
#1691556651
ls
#1691556659
ls -a
#1691556664
ls -s
#1691556670
cd ubuntu
#1691556766
git remote add origin git@github.com:Circular-Aflame/riyu_ubuntu.git
#1691556772
cd ubuntu
#1691556774
git remote add origin git@github.com:Circular-Aflame/riyu_ubuntu.git
#1691556788
git push -u origin main
#1691556802
git commit -m "first commit"
#1691556809
git branch -M main
#1691556815
git remote add origin git@github.com:Circular-Aflame/riyu_ubuntu.git
#1691556822
git push -u origin main
#1691556920
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691556940
git push -u origin main
#1691557055
git config --global user.email "395004472@qq.com"
#1691557090
git config --global user.name "Circular-Aflame"
#1691557093
git push -u origin main
#1691557103
git config --global user.name "Circular-Aflame"
#1691557112
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691557142
git init
#1691557148
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691557170
git remote rm origin
#1691557173
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691557177
git push -u origin main
#1691557495
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691557513
export https_proxy=http://127.0.0.1:7890
#1691557566
git init
#1691557590
git commit -m "first commit"
#1691557605
git branch -M main
#1691557614
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691557639
git remote rm origin
#1691557640
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691557648
git push -u origin main
#1691559701
lsof -i :7890
#1691559710
kill -9 716228
#1691559717
setsid ~/clash/clash-linux-amd64-v1.10.6 -d ~/clash
#1691559725
export https_proxy=http://127.0.0.1:7890
#1691559810
git push -u origin main
#1691559870
cd ..
#1691559872
ls
#1691559874
cd lighthouse/
#1691559879
java
#1691559893
git commit -m "ignore vosk"
#1691560016
git push -u origin main
#1691560136
git remote add origin https://github.com/Circular-Aflame/riyu_ubuntu.git
#1691560139
git push -u origin main
#1691560227
lsof -i :7890
#1691560238
kill -9 799472
#1691560241
sudo apt-get update
#1691560286
find jdk
#1691560297
java -version
#1691560359
update-alternatives --display name
#1691560388
git commit -m "ignore vosk"
#1691560393
sudo update-alternatives --display java
#1691560397
cd ubuntu
#1691560399
git commit -m "ignore vosk"
#1691560423
git push -u origin main
#1691560543
git rm -r --cached .
