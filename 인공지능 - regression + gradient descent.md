# Linear regression

**선형회귀(Linear regression)**
종속 변수 y와 한 개 이상의 독립 변수 X와의 선형 상관 관계를 모델링하는 회귀분석 기법이다. **단순 선형 회귀** - 한 개의 설명 변수에 기반한 경우
**다중 선형 회귀** - 둘 이상의 설명 변수에 기반한 경우

**비용(Cost)** : 가설(H(x) = Wx + b)이 얼마나 정확한지 판단하는 기준

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMjYz/MDAxNTI3MzU4NTAxMzQy.LeBbDHYT3TJyUF662UaELbRZYCKwpvwph3PGhAsg6Ewg.TLuPS7TBl4ZteSO364AdfkNxBu5t76O6RyOhQNS0ULAg.PNG.lyshyn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-05-27_%EC%98%A4%EC%A0%84_3.12.44.png?type=w2)

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfODQg/MDAxNTI3MzU5MTk4Mjc2.IBmP515M9ZdXR6R2jkSGWx4xvMfTu2VHNl0cV1VidxAg.DZmw3jbYZ7BAvEMTapAtgQYFHXU4OmoCgxrNtlDzXXYg.PNG.lyshyn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-05-27_%EC%98%A4%EC%A0%84_3.23.36.png?type=w2)

실제 데이터에 근접한 가설을 찾기 위해, 점(실제 데이터)와 선(가설) 사이의 거리가 최소가 되는 w와 b를 찾아야 한다.
이 때, w와 b를 찾는 함수를 **cost function**이라고 한다.
- linear한 선과 점 사이의 직선 거리를 구하기 위해서는 각각의 y값의 차이를 구하면 된다.
- `H(x)-y` 식을 이용할 경우 음수가 나올 수 있으므로 이 식의 제곱을 사용한다.
- 제곱을 취하기 때문에 거리가 멀수록 패널티가 커진다.

![이미지]https://postfiles.pstatic.net/MjAxODA1MjdfMTE0/MDAxNTI3MzYwNTAyOTMy.ydkD5nu8tx-ZNNEjQe5Zh5P9YfK1humDws32J_TycVcg.d162Y-NUZDjgCqzo_enGliuk4rBxbFfg8yYH5Meutxwg.PNG.lyshyn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-05-27_%EC%98%A4%EC%A0%84_3.37.36.png?type=w2)

**cost function**을 최소화하는 방법 중 하나가 **gradient descent(경사하강법)** 이다.
w값에 따라 계속 변하는 cost값은 아래와 같은 함수 형태로 나타낼 수 있다.

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMTI1/MDAxNTI3MzYxMzgzMzMz.8ZhMT_vx_zlZcDO1EqB93PXcUh09GwLRtMd2_DB4_Ggg.1kGvmhC6EGevbbUNtXMFnt1UMAmmWmaO84so-5vLb9gg.PNG.lyshyn/%E3%85%87.png?type=w2)

cost가 최소인 지점을 찾기 위해서는 순간기울기가 0인 부분을 찾으면 된다. 따라서, 해당 함수를 미분한다. 어떤 점에서 미분으로 구한 기울기 값이 음수면 w를 조금 증가시키고, 양수면 w를 조금 감소시키면 된다.

![이미지](https://blogfiles.pstatic.net/MjAxODA1MjdfNTkg/MDAxNTI3MzYyMDUwOTc4.HF7qndXy8YoufQzzzNjguAVicSJDe-XA22_ATrHZHtAg.RZgff3bUzpPZb71AcRaa_KtYbui3wupuAm5YyIo5eGIg.PNG.lyshyn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-05-27_%EC%98%A4%EC%A0%84_4.06.31.png)

---

# Logistic regression

지도학습 중 분류(classification)에 사용하는 알고리즘
이항 로지스틱 회귀분석은 분류하려는 범주가 `성공,실패` `예,아니오` `남/여` 등 2가지 범주로 나눠진 경우에 적용된다.

로지스틱 회귀와 선형 회귀의 차이점은
=> 선형회귀는 예측값의 범위가 실수
=> 로지스틱 회귀는 0~1의 범위(확률)

**선형회귀 => 로지스틱 회귀**
1. 무한의 값을 갖는 선형회귀 식을 통해 두 개의 값(0 또는 1)만을 갖는 결과가 필요하다.
2. 두 개의 결과만을 도출하는 과정이 연속되면 확률이 되며, 확률 또한 범위는 0부터 1까지로 제한된다.
3. 0부터 1까지로 값이 제한된 확률 값의 범위를 0부터 무한대로 확장하기 위해 odds를 취한다.

---

**odds란?**
![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMTU3/MDAxNTI3MzU1OTE0NjIz.TsOqX-gv9-LYBVLWqSUuqfaJsz93c72g6WxKsXqyp6Ug.n31Jozu0PaiEKC3ZYbSaQwnXh1VsQSDvJjUfydT-ZrEg.PNG.lyshyn/odds.png?type=w2)
실패 확률에 대한 성공 확률의 비율이다. 성공 확률을 p라고 한다면, 실패 확률은 1-p가 된다.

---

4. 0부터 무한까지로 확장된 결과를 다시 -무한대에서 무한대로 확장하기 위해 odds의 식에 자연로그를 취한다.
5. 이제 양쪽의 식이 모두 -무한대에서 무한대까지의 값을 갖게 되므로 등식이 성립하고 이 등식을 변형하면 우리가 원하는 로지스틱(=시그모이드) 함수가 도출된다.

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMTQ1/MDAxNTI3MzU2NjY4NDk4.PWqlhOvLMxAfWPd_g3_Un31gfkb5R-PAkJ0J086b-hcg.2qGhjfH9IgWjbP9fSNhUsX98qgoZenUE6mjI6Gcv8Eog.PNG.lyshyn/%EC%B5%9C%EC%A2%85%ED%95%A8%EC%88%98.png?type=w2)

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMTIw/MDAxNTI3MzU2NzgyOTU2.Nf3FzyQUspOJBpDoj1DYI4_8BSVR_UG-iL6fEZu08-Ug.g1lg5BqHsUSaCIgspUrh6yt7FkgGolCOiqZ2CnAZ6IYg.PNG.lyshyn/main-qimg-7c9b7670c90b286160a88cb599d1b733.png?type=w2)

![이미지](https://postfiles.pstatic.net/MjAxODA1MjdfMjI3/MDAxNTI3MzU2OTE4NTQw.Vo_z9kQAYu_U5NUAX8Jeb4K_RvEF9tANme2Afq4Ft6Mg.eZShGvApNJMNWgfQ3i3SHr2duGOkFGpMCuaGaSLyRD0g.PNG.lyshyn/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2018-05-27_%EC%98%A4%EC%A0%84_2.47.18.png?type=w2)



