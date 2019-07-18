# Support Vector Machine (SVM)

```
- 주제 : SVM(Support Vector Machines)
- 보충 : Logistic regression + gradient descent
```

- SVM은 Logistic Regression, Neural Network, Bayes classifier 같은 선형분류(Linear classifier, 초평면(hyperplane)을 이용하는 분류기)들 중에 하나이다.

- 초평면(hyperplane)이란,  주위 공간보다 한 차원 작은 부분 공간이다.
즉, N차원의 공간에서의 hyperplane은 N-1차원의 subspace를 의미힌다.
2차원의 경우  hyperplane은 1차원의 선이고,  3차원의 경우 hyperplane은 2차원의 면이다.

![이미지](https://wikidocs.net/images/page/5719/noname01.png)

---

![이미지](https://t1.daumcdn.net/cfile/tistory/263A444B58CFD2D834)

- 위의 그림과 같이 별모양과 동그라미가 있을 때, 두 도형을 나누는 가장 좋은 경계(boundary)를 찾을 때 사용되는 기계학습 기법 중 하나이다.

- 분류상으로는 지도학습(Supervised Learning)에 속한다.

- SVM에서 중요한 요소 3가지는 아래와 같다.
1. 마진 (Margin)
2. 서포트벡터 (Support Vector)
3. 커널 (Kernel)

- 위 세 가지에 대한 기본 개념을 알아야 뒤에 나올 아래 내용을 이해할 수 있다.
1. `최대마진분류기(Maximum margin classifier, Hard Margin SVM)`
2. `슬랙변수를 가진 SVM(Soft Margin SVM)`
3. `커널을 활용한 SVM(Soft Margin SVM with Kernel)`

---

### 1.1 마진(Margin)

마진은 하나의 데이터포인트(Support Vector)와 판별경계(Hyperplane) 사이의 거리를 말한다. 더 정확히는 각각의 클래스의 데이터 벡터들로부터 주어진 판별경계까지의 거리 중 가장 짧은 것을 말한다.

SVM에서는 이 마진이 클수록 분별을 잘하는 분류기인데, 이렇게 분류기와 데이터포인트 간의 거리(마진)을 두는 이유는 학습오차와 일반화오차 중 일반화오차 부분 즉 데이터 속에서 내재하는 기본적인 오차부분(노이즈) 정도를 표현하기 위해 존재한다.

자세히 설명하면, 일반적으로 학습데이터에 과다적합될수록 높은 복잡도의 비선현 분류기가 되는데 이렇게 되면 학습데이터의 노이즈까지 학습시켰기 때문에 오차는 커지는 현상이 발생한다. 따라서 학습데이터에 일정정도의 오차를 내야(노이즈는 학습을 시키지 않는다는 의미) 최적의 분류기가 나온다. SVM에서는 이 오차를 마진(Margin)으로 둔 것이다. 이를 통해 일반화 오류를 줄이면서 데이터 판별의 정확도를 높일 수 있다.

![이미지](https://t1.daumcdn.net/cfile/tistory/214C754256DD55552E)

요약하면, `마진(Margin)은 여러개의 판별경계 후보가 있을 때, 벡터공간에서의 가장 합리적인 판별경계를 찾을 수 있는 기준이다.`

---

### 1.1-1 VC Dimension

우리가 위에서 마진을 크게하는 분류기일수록 좋은 분류기라고 했는데, 이렇게 Classifier가 얼마나 좋은 성능을 내는지를 보여주기 위한 척도 중 하나라고 볼 수 있는 VC dimension에 대해 설명을 하겠다.

VC Dimension은 얼마나 복잡한 데이터를 분류할 수 있는지를 나타내는 속성이다.

Shattering 과 Dichotomy 로 구성된다.
Dichotomy는 말그대로 데이터포인트를 나누는 것을 의미한다.

![이미지](https://t1.daumcdn.net/cfile/tistory/2522D33658CFE12533)

Shattering는 분류기가 Dichotomy를 얼마나 표현할 수 있는지를 나타낸다.
위의 그림 중 마지막 그림을 보면 +와 -를 나누는 선 하나를 표현할 방법은 없다.
즉, 해당 경우의 Dichotomy는 표현할 수 없다는 의미이다.

정리하면, 분류기의 의해 Shattered 될 수 있는 이 데이터포인트의 최대 개수를 바로 분류기의 VC Dimension 이라고 한다.
따라서 VC Dimension은 분류기의 데이터 수용능력(capacity)을 측정한다.

보통 N 차원의 선형분류기에서는 VC Dimension은 N+1 이라고 한다.
VC Dimension이 높으면 분류를 잘해서 좋은 성능을 낼 것이라고 생각할 수 있는데, 일반적으로 VC Dimension이 높아지면 일반화 오류가 높아져 과적합(Overfitting) 문제가 발생할 수 있다. 따라서, 학습할 데이터의 차원이 높아질수록 해당차원의 노이즈까지 학습하게 되므로 전체적으로 일반화 오차가 커지는 현상이 나타나기 때문에 VC Dimension은 높으면 좋지 않다.

정리하면, 과적합(Overfitting)을 막기 위해서 VC Dimension을 낮추면 Shattering 할 수 있는 데이터셋을 줄여야하는데, 이 데이터셋을 줄이는 방법이 마진(Margin)인 것이다.

---

### 1.2 서포트 벡터(Support Vector)

![이미지](https://t1.daumcdn.net/cfile/tistory/2508A13A56DD63DA19)

초서포트 벡터는 평면(hyperplane, 판별경계)까지의 거리가 가장 짧은 데이터 벡터이다.
즉, 위에서 말한 데이터포인트가 바로 서포트 벡터이다.

서포트 벡터로 인해서 SVM이 가지는 장점은 새로운 데이터포인트가 생겼을 때, 서포트 벡터와의 내적거리만 구하면 되므로 계산을 상당히 줄일 수 있다.

---

### 1.3 커널(Kernel)

선형분류가 어려운 저차원 데이터를 고차원으로 변환 후 SVM과 같은 분류 모델로 학습(계산)을 하는 것은 경우에 따라서 많은 연산비용이 소모된다.

![이미지](https://image.slidesharecdn.com/svmv0-170619005336/95/svm-14-1024.jpg?cb=1497833721)

수학적으로 고차원 데이터인 `a^,b^`를 내적하는 것과, 내적한 결과를 고차원으로 보내는 것은 동일한 결과를 가진다.


![이미지](https://image.slidesharecdn.com/svmv0-170619005336/95/svm-15-1024.jpg?cb=1497833721)

여기서 나온 내적함수가 바로 커널 함수이고, 이렇게 계산량을 줄이는 방법을 커널법 또는 커널트릭(Kernel Trick)이라고 부른다.

![이미지](https://image.slidesharecdn.com/svmv0-170619005336/95/svm-22-1024.jpg?cb=1497833721)

이러한 커널트릭은 SVM뿐 아니라 Gaussian Processes, PCA 등 모든 비선형 문제를 가진 분류기에서 사용할 수 있다.

---


















