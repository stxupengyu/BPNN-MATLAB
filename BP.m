%创建训练样本输入集
clc,clear
num=24;%对应24个特征
len=9;%有9行数据
data=xlsread('data_new');
data=data(2:len+1,:);

%建立训练集测试集
x_train=[data(1:len-2,:).'];
x_test=[data(len-1,:).'];
y_train=[data(2:len-1,:).'];
test=[data(len,:).'];

%创建BP神经网络
%创建网络
net=newff(minmax(x_train),[7,24],{'tansig','purelin'},'trainlm');%隐层神经元个数，输出层神经元个数,第1个参数为测试输入的输入范围
%设置训练次数
net.trainParam.epochs = 100;
%设置收敛误差
net.trainParam.goal=0.001;
%训练网络
[net,tr]=train(net,x_train,y_train);
%在训练集和测试集上的表现
y_train_predict=sim(net,x_train);
Predict=sim(net,x_test);
%作图 分别在测试集上
x=0:1:23;
plot(x,Predict,x,test);
grid on
xlabel('时间'),ylabel('用电量')%命名
legend('预测值','真实值');
rmse=(sum((Predict-test).^2)/24)^0.5
mae=sum(abs(Predict-test))/24
mape=sum(abs(Predict-test)./test)/24*100

