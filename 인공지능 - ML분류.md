# 기계학습(Machine Learning) 분류

머신 러닝(Machine Learning)이란 “데이터를 이용해서 컴퓨터를 학습시키는 방법론”이다.
이때, 머신 러닝 알고리즘은 크게 세가지 분류로 나눌 수 있다. 바로, `지도 학습`(Supervised Learning), `비지도 학습`(Unsupervised Learning), `강화 학습`(Reinforcement Learning)이다.

![이미지](http://solarisailab.com/wp-content/uploads/2017/06/supervsied_unsupervised_reinforcement.jpg)
그림 1 – 머신 러닝 알고리즘의 분류 [1]

---

### 지도 학습(Supervised Learning)

지도 학습(Supervised Learning)은 데이터에 대한 레이블(Label)-명시적인 정답-이 주어진 상태에서 컴퓨터를 학습시키는 방법이다.

즉, (데이터(data), 레이블(label)) 형태로 학습을 진행하는 방법이다. 예를 들어서, 아래와 같은 28×28 크기의 이미지인 MNIST 데이터셋이 있으면, 이를 이용해 학습을 진행할때, 트레이닝 데이터셋(training set)은 아래와 같이 구성될 것이다.

(0을 나타내는 28×28 이미지, 0), (7을 나타내는 28×28 이미지, 7), (6을 나타내는 28×28 이미지, 6), (0을 나타내는 28×28 이미지, 0), …

![이미지](http://solarisailab.com/wp-content/uploads/2016/05/mnist_2.gif)
그림 2 – MNIST 데이터셋

이렇게 구성된 트레이닝 데이터셋으로 학습이 끝나면, 레이블(label)이 지정되지 않은 테스트 데이터셋(test set)을 이용해서, 학습된 알고리즘이 얼마나 정확히 예측(Prediction)하는지를 측정할 수 있다.

예를 들어서,

(4을 나타내는 28×28 이미지)

를 학습된 분류기에 집어 넣으면, 올바르게 4를 예측 하는지(True Prediction) 아니면 3이나 5와 같은 잘못된 레이블을 예측하는지 (False Prediction) 측정할 수 있다.

이때, 예측하는 결과값이 discrete value(이산값)면 classification(분류) 문제-이 이미지에 해당하는 숫자는 1인가 2인가?-,

예측하는 결과값이 continuous value(연속값)면 regression(회귀) 문제-3개월뒤 이 아파트 가격은 2억1천만원 일 것인가? 2억2천만원 일 것인가?-라고 한다.

딥러닝에서 Supervised Learning 방법론으로 주로 사용되는 구조는 Convolutional Neural Network(CNNs), Recurrent Neural Networks(RNNs)이다.

---

### 비지도 학습(Unsupervised Learning)

비지도 학습(Unsupervised Learning)은 데이터에 대한 레이블(Label)-명시적인 정답-이 주어지지 않은 상태에서 컴퓨터를 학습시키는 방법론이다.

즉, (데이터(data)) 형태로 학습을 진행하는 방법이다. 예를 들어서, 아래와 데이터가 무작위로 분포되어 있을때, 이 데이터를 비슷한 특성을 가진 세가지 부류로 묶는 클러스터링(Clustering) 알고리즘이 있다.

![이미지](http://solarisailab.com/wp-content/uploads/2017/06/unsupervised_learning.jpg)
그림 3 – Clustering 알고리즘 [2]

비지도 학습은 데이터의 숨겨진(Hidden) 특징(Feature)이나 구조를 발견하는데 사용된다.

딥러닝에서 Unsupervised Learning 방법론으로 주로 사용되는 구조는 Autoencoders이다.

---

### 강화 학습(Reinforcement Learning)

강화 학습(Reinforcement Learning)은 앞서 살펴본 지도 학습(Supervised Learning)과 비지도 학습(Unsupervised Learning)과는 약간은 다른 종류의 학습 알고리즘이다.

앞서 살펴본 알고리즘들이 데이터(data)가 주어진 정적인 상태(static environment)에서 학습을 진행하였다면, 강화 학습(Reinforcement Learning)은 에이전트가 주어진 환경(state)에 대해 어떤 행동(action)을 취하고 이로부터 어떤 보상(reward)을 얻으면서 학습을 진행한다.

이때, 에이전트는 보상(reward)을 최대화(maximize)하도록 학습이 진행된다. 즉, 강화학습은 일종의 동적인 상태(dynamic environment)에서 데이터를 수집하는 과정까지 포함되어 있는 알고리즘이다.

![이미지](http://solarisailab.com/wp-content/uploads/2015/11/%EA%B0%95%ED%99%94%ED%95%99%EC%8A%B5.jpg)
그림 4 – 강화학습(Reinforcement Learning) 알고리즘

강화학습의 대표적인 알고리즘은 Q-Learning이 있고, 딥러닝과 결합하여 Deep-Q-Network(DQN) 방법으로도 사용된다.