import sys
import json
import os
import pykakasi

# 绝对路径
path=sys.argv[1]

# 获取 path 路径下一级文件中的 wav，txt，转化出 lab
def listdir(path, list_wav_name, list_txt_name):
  for file in os.listdir(path): 
    file_path = os.path.join(path, file) 
    # 递归查看子目录
    # if os.path.isdir(file_path): 
    #   listdir(file_path, list_wav_name, list_txt_name) 
    # elif os.path.splitext(file_path)[1]=='.wav': 
    #   list_wav_name.append(file_path)
    # elif os.path.splitext(file_path)[1]=='.txt': 
    #   list_txt_name.append(file_path)

    # 只看一级目录
    if os.path.splitext(file_path)[1]=='.wav': 
      list_wav_name.append(file_path)
    elif os.path.splitext(file_path)[1]=='.txt': 
      list_txt_name.append(file_path)

wav_list = []
txt_list = []

listdir(path, wav_list, txt_list) # 只接受wav，txt文件

wav_name_list = [wav[(len(path)):-4] for wav in wav_list ] # 默认文件后缀名为 .txt 或者 .wav
txt_name_list = [txt[(len(path)):-4] for txt in txt_list ]

for i in range(len(wav_name_list)):
    if wav_name_list[i][0] == '/':
        wav_name_list[i] = wav_name_list[i][1:]
for i in range(len(txt_name_list)):
    if txt_name_list[i][0] == '/':
        txt_name_list[i] = txt_name_list[i][1:]

print(wav_name_list)
print(txt_name_list)


name=wav_name_list[0]

cmd = "mfa tokenize " + path + " /home/ubuntu/Documents/MFA/pretrained_models/tokenizer/japanese_mfa.zip " + path 
string_cmd = f"source ~/anaconda3/etc/profile.d/conda.sh && conda activate aligner && {cmd}"
print(string_cmd)
os.system(f'bash -c "{string_cmd}"')

cmd="mfa align --clean --output_format json " + path + " japanese_mfa japanese_mfa /home/ubuntu/test/cache"
string_cmd = f"source ~/anaconda3/etc/profile.d/conda.sh && conda activate aligner && {cmd}"
print(string_cmd)

os.system(f'bash -c "{string_cmd}"')
# os.system("conda activate aligner")
# os.system(cmd)
# os.system("conda deactivate") 

store_path = "/home/ubuntu/test/"

data = {}
with open(store_path + "cache/"+name+".json", 'r') as f:
    data = json.load(f)
input=data["tiers"]["phones"]["entries"]
words=data["tiers"]["words"]["entries"]

dic={}
with open(store_path + "phones.json",'r') as d:
    dic=json.load(d)

# 获取平均辅音长度
num=0
total=0
for phone in input:
    if phone[2] in dic["cuyin"]:
        num+=1
        total+=(phone[1]-phone[0])
mean=round(total/num,2)
print(mean)

kana=[]
temp=[]
conson=False
seq=0
for phone in input:
    print(phone)
    if len(phone[2])==0:
        continue
    if phone[2]=="spn":
        while seq<len(words):
            if phone[0]==words[seq][0]:
                del words[seq]
                break
            else:
                seq+=1
        continue
    if phone[2] not in dic["vowels"]:
        if phone[2] in dic["lengths"]:
            temp.append(phone[0])
            temp.append(phone[1]-mean)
            temp.append(1)
            kana.append(temp)
            temp=[]
            conson=True
            temp.append(phone[1]-mean)
        else:
            if phone[2] in dic["hatsuon"]:
                time=phone[1]-phone[0]
                if time > mean*1.5:
                    temp.append(phone[0])
                    temp.append(phone[1])
                    temp.append(1)
                    kana.append(temp)
                    temp=[]
                    conson=False
                    continue
            conson=True
            temp.append(phone[0])
    if phone[2] in dic["vowels"]:
        if not conson:
            temp.append(phone[0])
        temp.append(phone[1])
        if phone[2] in dic["lengths"]:
            temp.append(2)
        else:
            temp.append(1)
        kana.append(temp)
        temp=[]
        conson=False

print(kana)

kanas=[]
start_time=[]
end_time=[]
c=0

name=""
for word in words:
    name+=word[2]
print(name)

# 转换为平假名
kks=pykakasi.kakasi()
names=kks.convert(name)
name=""
for n in names:
    name+=n['hira']
print(name)

for word in kana:
    print(word)
    start_time.append(word[0])
    end_time.append(word[1])
    # 获取下一个假名
    string=name[c]
    c+=1
    if c < len(name):
        if name[c] in dic["small"]:
            string+=name[c]
            c+=1

    addword=string
    if word[2]==2:
        # 获取下一个假名
        strin=name[c]
        c+=1
        if c < len(name):
            if name[c] in dic["small"]:
                strin+=name[c]
                c+=1

        addword+=strin
    kanas.append(addword)

output={
    "kanas":kanas,
    "starts":start_time,
    "ends":end_time
    }

outf=open(path + "/" + "output.json",'w')
outf.write(json.dumps(output,indent=1))
print(output)
outf.close()

# os.system("rm -rf /home/ubuntu/test/cache")
# os.system("mkdir /home/ubuntu/test/cache")