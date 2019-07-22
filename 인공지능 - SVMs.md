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
1. 최대마진분류기(Maximum margin classifier, Hard Margin SVM)
2. 슬랙변수를 가진 SVM(Soft Margin SVM)
3. 커널을 활용한 SVM(Soft Margin SVM with Kernel)

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

### 최대마진분류기(Maximum margin classifier, Hard Margin SVM)

최대마진 분류기는 마진(Margin)을 최대로 하는 선형 결정경계를 찾는 분류기를 말한다.
가장 일반적인 서포트벡터머신(SVM)이다.

위의 최대마진 분류기법은 모든 학습 데이터들에 대해서 정확하게 분류될 것을 그 제약조건으로 가지고 있다. 하지만 이렇게 판별이 가능하다는 것은 현실적으로 불가능하다.
따라서 약간의 오분류를 허용하도록 제약조건을 수정해야할 필요성이 생기는데 여기서 나오는 것이 바로 슬랙변수를 가진 SVM(혹은 Soft Margin SVM)과 커널법을 이용한 Soft Margin SVM이다.

---

### 슬랙변수를 가진 SVM(Soft Margin SVM)

![이미지](https://t1.daumcdn.net/cfile/tistory/234CF44156E04DD520)

위 그림처럼 선형분리가 되지 않고 잘못 분류되는 데이터가 존재하는데, 이를 처리하기 위해 먼저 잘못 분류된 데이터로분터 해당 클래스의 결정 경계까지의 거리를 나타내는 슬랙변수를 도입한다. 따라서 슬랙변수가 클수록 더 심한 오분류를 허용함을 의미한다.

약간의 오분류를 허용하는 선형 판별경계를 찾는 Soft Margin SVM은 특징적으로는 최대마진 분류기와 동일하다.
일부 데이터가 선형으로 예측할 수 없는 상황에서 슬랙변수를 써서 이를 선형으로 예측할 수 있게 하였으나, 애초에 데이터의 특성상 데이터 클래스 사이의 경계가 선형성이 없는 경우에는 이마저도 사용할 수가 없다.
따라서 이러한 비선형 판별경계(hyperplane)를 갖는 데이터를 선형 판별경계로 분류하게 만드는 방법이 있는데, 이것이 바로 위에서 설명했던 커널법(Kernel Trick)이다.

---

### 커널법을 활용한 SVM(Soft Margin SVM with Kernel)

![이미지](https://t1.daumcdn.net/cfile/tistory/2346843B56E061EE06)

위의 데이터 분포에서는 초평면(hyperplane) 자체가 없기 때문에 아예 슬랙변수조차 사용할 수가 없다. 이러한 비선형 문제를 해결하기 위해서 저차원의 입력을 보다 고차원의 값으로 매핑시키는 함수를 생각할 수 있다.

![이미지](https://t1.daumcdn.net/cfile/tistory/2646603B56E062DF07)

위의 데이터 분포를 보면 2차원 공간상에서는 두 클래스는 원형의 결정경계를 가지는 비선형 문제였지만, 이것을 3차원 공간으로 변형하면 선형 평면으로 분류가 가능한 선형 문제로 변화가 된다.

각 고차원 벡터가 선형분포를 따르면, 둘의 내적도 반드시 선형분포를 따를 것이다.
따라서 두 내적공간만 정의를 해줘서 선형 판별경계를 찾을 수 있다.
이때 정의된 내적함수를 커널함수라고 부르며, 정의는 아래와 같다.

![이미지](https://t1.daumcdn.net/cfile/tistory/270F374C56E0671705)

이러한 커널트릭을 적용한 라그랑주 함수는 다음과 같다.

![이미지](https://t1.daumcdn.net/cfile/tistory/2734D84556E067EF09)

판별 경계는 다음과 같다.

![이미지](https://t1.daumcdn.net/cfile/tistory/256B5B4B56E0682F07)

이렇게 고차원 매핑을 통해 비선형 문제를 선형화하여 해결하면서, 커널함수를 통해 계산량 증가의 문제를 해결하는 방법을 커널법 혹은 커널트릭이라고 하며 SVM을 비롯해 선형성을 가정하는 방법론에서 활발히 사용되고 있다.

몇가지 대표적인 커널 함수로는 선형커널, 다항식커널, 시그모이드커널, 가우시안커널이 있다.

![이미지](https://t1.daumcdn.net/cfile/tistory/2310AF4C56E06AF407)

각 커널함수는 고유의 파라미터(다항식 커널의 r과d, 시그모이드 커널의 r 등)를 가지고 있으며, 이것은 문제의 성격에 맞추어 적절히 조정해주어야 하는 하이퍼파라미터(Hyper-Parameter)이다.

---

장 많이 사용되는 SVM 알고리즘으로는 LIBSVM(A Library for Support Vector Machines)이 있으며, 개발 언어는 C/C++으로 개발되었습니다.

언어는 C/C++으로 개발되었지만 Java, R, Matlab(Octave), Python 등 다양한 언어에서 사용될 수 있도록 인터페이스가 함께 개발되어 제공되고 있으므로 원하시는 언어로 개발을 하시면 됩니다.

아래의 페이지에 접속 하시면 SVM 라이브러리에 대한 소개가 있습니다.

https://www.csie.ntu.edu.tw/~cjlin/libsvm/index.html

페이지 중간 쯔음에 그래픽 인터페이스를 제공하여, 직접 데이터를 입력하여 SVM 알고리즘의 기능을 테스트 해보실 수 있습니다.

테스트는 2가지 형태의 데이터를 나눠서 입력하여 어떻게 SVM에서 분류를 할 수 있는지 확인해 보도록 하겠습니다.

[SVM Lib 클릭](https://www.csie.ntu.edu.tw/~cjlin/libsvm/index.html)

---

[svm 보충자료](https://bskyvision.com/163)











