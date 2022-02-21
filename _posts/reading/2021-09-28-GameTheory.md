---
layout: post
title: 博弈论
description: >
  学习博弈论时所做的笔记
sitemap: false
hide_last_modified: true
categories: [reading]
tags: [reading]
---

0. this line will be replaced by toc
{:toc}

#### 概述

等边际原理：最优的资源配置必须资源在每种用途上的边际贡献都需相等
羊群效应：大家做什么，自己也跟着做什么，不管对错

社会的基本问题：**协调问题**、**合作问题**

协调问题的核心是人们如何预测他人的行为，最直接的办法是沟通和交流，需要行为规范的知识、对对方特性的知识，甚至对方如何看待己方的**高等知识**

**集体理性**：满足收益最大化的选择或对所有成员都最好的选择

**合作问题**（合作困境）：个体理性和集体理性存在冲突
**囚徒困境**：个体理性和集体理性发生冲突的情况

正式制度和非正式制度（明规则和潜规则）
价格制度和非价格制度

#### 博弈论

**博弈论假设**：

- 博弈的每个人都是**工具理性**的
  **理性人**：拥有一个**明确的**偏好，在给定约束条件下追求自我偏好满足的最大化（并非自私自利）

  - **明确的**
    - 完备性：喜爱程度是可以比较的
    - 传递性：$A > B, B > C, then\ A > C$
  - **偏好连续**
    满足程度不会跳跃。可以用函数来刻画选择和满足程度的关系，称为**效用函数**，可以用**无差异曲线**表示。不满足连续性假设的叫做**词典序偏好**
  - **约束条件**
    最优选择由偏好和约束条件共同决定

  满足效用函数，明确约束条件后可以用**最优化方法**计算人的行为，常用**预期效用理论**（某一选择在不同事件下得到的效用水平的加权，权数是事件出现的概率）

  - **批评**
    - 有限理性
    - 有限毅力
    - 有限自利：利他主义和情绪化行为
  - **意义**
    - 没有更好的其他可选择的理论
    - 人在长期来看是理性的，否则他无法生存
    - 将问题集中于社会制度的优劣上

- “每个参与人都是工具理性的”是所有参与人的**共同知识**

- 所有参与人都了解博弈规则

**帕累托标准**

- **帕累托效率**（帕累托最优）：一种社会状态，与该状态相比，不存在另外一种可选择的状态，使得至少一个人的处境变得更好而同时没有任何其他人的处境变得更差
- **帕累托改进**：改变一种状态，使没有任何人的处境变坏，但至少有一个人的处境变好（从非帕累托最优点到帕累托最优点不一定是一个帕累托改进）
- 将帕累托效率作为社会最优——集体理性的标准（三者等同）

**卡尔多·希格斯标准**（总量最大化标准）

- 如果一种变革，受益者的所得可以弥补受损者的损失
- 可能通过谈判转化为帕累托改进（交易成本为零时，必定有）

**博弈论基本概念**：

- **参与人**：博弈中的决策主体；自然作为虚拟参与人（没有自己的支付和目标函数）
- **行动**：在博弈的某个时间点的决策变量，行动的集合称为**行动组合**；行动的顺序
- **信息**：在博弈中每个人知道些什么，用**信息集**来描述；如果参与人对其他人的**行动**的信息掌握得非常充分，则叫这类博弈为**完美信息博弈**，如果对其他人的特征和类型的信息掌握得比较充分，则称为**完全信息博弈**
  - 静态博弈和动态博弈（序贯博弈）：
    所有参与人同时行动且只能行动一次；一方先行动，一方后行动
- **战略**：
  相机行动计划，它规定了参与人在什么情况下该如何行动
  - 完备性：针对所有情况都要制定计划
- **支付**：每个参与人在给定**战略组合**（所有参与人所选择的战略的集合）下得到的报酬
- **均衡**：博弈的一种稳定状态（最优战略组合），所有参与人不愿意单方面改变自己的战略，这样的稳定状态是由所有参与人的**最优战略**组成的
- **博弈的结果**：参与人和分析者所关心的博弈均衡情况下所出现的东西

**囚徒困境**：个人理性和集体理性的矛盾

- **占优战略**：博弈中参与人的某一个战略在任何情况下都可以给自己带来最大支付；由占优战略组成的战略组合构成了博弈的**占优战略均衡**

- **公共产品**：消费起来不会排斥他人的物品或服务，与之相对的是**私人物品**

- **囚徒困境的一般形式**
  $$
  \begin{array}{|c|c|c|}
  \hline
  参与人&\space合作\space&不合作\\
  \hline
  合作&T,T&S,R\\
  \hline
  不合作&R,S&P,P\\
  \hline
  \end{array}
  \\
  满足条件R>T>P>S
  $$
  加入惩罚$X$
  $$
  \begin{array}{|c|c|c|}
  \hline
  参与人&\space合作\space&不合作\\
  \hline
  合作&T,T&S,R-X\\
  \hline
  不合作&R-X,S&P-X,P-X\\
  \hline
  \end{array}
  \\
  满足条件R>T>P>S,\space R-X<T
  $$

**智猪博弈**

- **劣战略**：在任何情况下都不是最优选择的战略
- **重复剔除占优策略均衡**：相继剔除劣战略
- **理性共识**
  - 零阶
  - 一阶
  - 二阶
  - 无限阶次

#### 纳什均衡

**纳什均衡**：所有参与人的最优战略组合

- **一致预期**：信念和选择是一致的
- **纯战略纳什均衡**：两个战略互为最优
- **混合战略纳什均衡**：参与人以某一概率选择某一行动

**多重均衡**

- 例子

  - 交通博弈：无利益冲突
  - 约会博弈：有利益冲突
  - 资源争夺博弈：严重利益冲突

  均衡过多可能导致均衡无法出现

- **聚点均衡**：多重纳什均衡中人们预期最可能出现的纳什均衡

- **廉价交谈**（无成本交流）：双方交流中都不会故意撒谎，而是实话实说（没有严重利益冲突），此时对所有人都有利的帕累托均衡可能会出现

- **法律和社会规范**：法律和社会规范是协调预测，从而实现纳什均衡的重要工具；本身就是一个纳什均衡（理性人长期互动的结果）

- **文化**：文化是人们长期博弈的结果，不同文化的冲突实际上是不同游戏规则的冲突

  - 用其中一个规则取代其他规则
  - 建立全新的规则
  - 建立协调规则的规则

- **锁定效应和路径依赖**：初始的选择决定了未来的选择，不是帕累托最优却是纳什均衡

#### **动态博弈**

**动态博弈**

- 用**博弈树**描述
  事前最优战略和事后最优战略可能不同
- **威胁**：威胁性和许诺性的声明（统称为威胁）
  - **不可置信威胁**
- **序贯理性**：不管事前制定的计划如何，参与人在新的时点上的决策都应该根据当前的情形选择最优的行动
- **精炼纳什均衡**（序贯均衡）：不包含不可置信的行动的战略组合组成的纳什均衡（要求博弈的参与人是序贯理性的）；在博弈树上经过的决策点和最优选择称为**均衡路径**
- **子博弈**：在某一时点所面临的决策情形
  **真子博弈**
  精炼纳什均衡又称为**子博弈精炼纳什均衡**
- **逆向剔除**
- **反事实悖论**：认为一件事不可能，就可能；认为不可能则可能
- **承诺**：事后可以置信的威胁
  - 关键是成本
  - 实质是限制自己的选择范围
  - 可能达成帕累托最优均衡
  - **宪政和民主**
    - **有限政府**：提高政府违约时的惩罚
      将宪法和法律作为承诺
    - **民主作为承诺**：选举制度

**讨价还价**：既有共同利益，又有利益冲突

- 实质上是一种具有利益冲突的**正和博弈**

- **合作博弈和非合作博弈**：集体理性和个体理性

- **合作博弈**（公理化方法）

  - **纳什谈判解**
    $$
    \begin{array}{|c|c|}
    \hline
    参与人 & A\ B\\
    \hline
    威胁点（谈判砝码）& a\ b\\
    \hline
    剩余 & V-a-b \\
    \hline
    \end{array}
    $$
    
    - 帕累托有效：全分配完
  - 线性转换不变性：期望效用水平不受度量的标量影响
    - 对非相关选择的独立性：无关的选择不会影响讨价还价的结果
    
    如果所有参与人都认可上述三个公理性假设，而且知道对方也认可这些假设（**共同知识**）时，有
    $$
    when\ x+y \le V(x,y),\\
    and\ W(x,y)=(x-a)^h(y-b)^k\\
    then\ \frac{y-b}{x-a}=\frac{k}{h}
    $$
    
    - 边际贡献和可替代性：谈判能力$h,k$
    - 改变谈判筹码

- **非合作博弈**（战略式方法）

  - 分蛋糕：存在唯一**精炼纳什均衡**

    - 出价顺序
    - 耐心程度
    - 谈判成本
    - 最后期限

  - **贴现因子**：衡量未来的收益贴现到现在的价值，越接近1说明未来收益在现在的价值大，重视未来，有耐心

    | 轮数 |        分配         |
    | :--: | :-----------------: |
    |  1   | $1-((1-m)n),(1-m)n$ |
    |  2   |       $m,1-m$       |
    |  3   |        $1,0$        |

    - **后动优势**：耐性都足够高，谁最后一轮出价就有优势
    - 越有耐心的人，优势越大

  - **无限期谈判和耐心**
    $假设T>3,\ res(T)=(x,1-x),\ res(T)=res(T-2)$
    无限期谈判具有**先动优势**

  - **贴现率和谈判力**$mn\ hk$
    $$
    s=\frac{1-m}{m},\ r=\frac{1-n}{n} \\
    \frac xy = \frac hk \cong \frac rs \\
    h=\frac r{r+s},\ k=\frac s{r+s}
    $$

  - **谈判成本**

    - 固定成本：双方都会为谈判付出一定成本
    - 外部机会损失：因为谈判而放弃的机会

    谈判成本高的处于劣势

  - 谈判最大的问题：**信息不完全**
    谈判过程的实质：信息揭示和窥探；信息完全时，谈判的结果一定是帕累托最优

- **无规范约束的讨价还价**

  - **规范**
    - 程序规范：规则
    - 实体规范：公平公正等
      **平等原则和公平原则**

- 公理化方法：筹码、边际贡献
  战略式方法：顺序、次数、耐心、成本

#### 重复博弈

**重复博弈和合作**

- **重复博弈**是一种特殊的动态博弈，重复博弈中的每一个子博弈称为**阶段博弈**

  - 阶段博弈之间没有物理上的联系
  - 每个参与人都能观察到过去的历史
  - 每个参与人得到的最终报酬是各个阶段博弈支付的贴现值之和

  分为**有限次重复博弈**和**无限次重复博弈**

- 在重复博弈情况下，合作对每个理性人来说可能是最好的选择

  - 重复博弈可以改变参与人的战略空间（观察历史，将自己的行动建立在其他参与人过去的行动历史之上）
  - **针锋相对**（tit-for-tat）
  - **触发战略或冷酷战略**（trigger strategy）

- **合作的价值**（$\delta$是对未来的重视程度（贴现因子a）或参与人预期博弈重复的可能性（概率b））$\delta=ab$
  维持长期合作：$V=T+\delta^1T+\delta^2T+\delta^3T+\cdots=\frac T{1-\delta}$
  针锋相对$\delta \ge \frac{R-T}{R-P}$时，选择总是背叛不是最优
  触发战略：$\delta \ge \frac{R-T}{R-P}$可以表述为$\frac{\delta(T-P)}{1-\delta} \ge R-T$，左边是未来损失，右边是当期增加值

- 惩罚

  - 两次欺骗才被发现

  $$
  \frac T{1-\delta} \ge R(1+\delta)+P\frac{\delta^2}{1-\delta}\\
  \delta \ge \sqrt{\frac{R-T}{R-P}} \gt \frac{R-T}{R-P}
  $$

  欺骗越难被发现，合作越不可能

  - **严厉可信惩罚**：欺骗一次，惩罚多次
    若取三次$T+\delta^1T+\delta^2T+\delta^3T>R+\delta^1P+\delta^2P+\delta^3P$
    
  - 惩罚$S$
    $$
    T+\delta T>R+\delta S \to \delta>\frac{R-T}{T-S}\\
    S+\delta T>P+\delta S \to \delta>\frac{P-S}{T-S}
    $$
    
  - **单边囚徒困境**
    只有一方参与人有机会主义行为（垄断）
  
  - **过犹不及**
    最优惩罚问题
  
- 多重关系下的合作：多重交易关系在一定条件下促进了合作的实现

- 连带责任机制

#### 信息不对称

**不完全信息和声誉**

- **有限次重复博弈中的合作**
  “连锁店悖论”逆向归纳逻辑和现实的实践存在矛盾

- **不完全信息**：一方参与人对另一方的偏好、支付函数、战略等方面的知识是不完全的，用**类型**来刻画不完全信息

  - 博弈两次

$$
\begin{array}{|c|cc|}
  \hline
  & t=1&t=2\\
  \hline
  A(非理性)(p) & 合作 & X \\
  A(理性)(1-p) & 背叛 & 背叛 \\
  \hline
  B(理性) & X & 背叛 \\
  \hline
  \end{array} \\
  W=
  \begin{cases}
    p \times R + (1-p) \times P + p \times P + (1-p) \times P & X=背叛\\
    p \times T + (1-p) \times S + p \times R + (1-p) \times P & X=合作
  \end{cases}
$$

- 博弈三次
  
$$
  \begin{array}{|c|ccc|}
  \hline
  & t=1 & t=2 & t=3 \\
  \hline
  A(非理性)(p) & 合作 & X & Y \\
  A(理性)(1-p) & ？& 背叛 & 背叛 \\
  \hline
  B(理性) & X & Y &背叛 \\
  \hline
  \end{array} \\
若A选择第一阶段合作则等同于上述两次博弈
$$
  - 博弈三次以上时，存在以下战略组合构成**精炼纳什均衡**

$$
  provide\ that\ p \ge 0.25,\ for\ any\ T \ge 3 \\
  A
  \begin{cases}
  cooperate & t = 1, 2,\cdots, T-2 \\
  betray & t = T-1, T
  \end{cases}\\
  B
  \begin{cases}
  cooperate & t = 1, 2, \cdots, T-1 \\
  betray & t = T
\end{cases}
$$

- 如果双方都有不完全信息，不论$p$多小，只要博弈次数足够多（不需要无限次），合作就会出现
    对于任何给定的$p$，存在一个博弈重复次数的临界值$T^*$，但重复次数低于这个临界值时，参与人会选择背叛$\begin{cases}cooperate & 0 \to T-T^* \\betray & T-T^*+1 \to T \end{cases}$
  
- 解开“连锁店悖论”
    伪装低成本
  
  - 贝叶斯法则
$$
    p(\theta^0|g)=\frac{p(g|\theta^0)p(\theta^0)}{p(g)}=\frac{p(g|\theta^0)p(\theta^0)}{p(g|\theta^0)p(\theta^0)+p(g|\theta^1)p(\theta^1)}
$$

**非对称信息**：交易一方拥有但不被交易的另一方所知道的信息

- **事前的非对称信息**：在双方发生交易关系之前就存在的信息不对称

- **事后的非对称信息**：双方发生了交易关系之后，一方不能观测到对方的行动

- 信息不对称导致的**逆向选择**：“劣胜优汰”，常用**劣币驱逐良币**类比

- **信息不完全情况**下，对车的评价a和好车比例p足够大，否则**市场失灵**（市场失灵区域）

  - **市场机制和非市场机制**
    处于劣势的一方主动收集信息（信息提供商），优势一方也有动力传递信息

  - 间接获取（“**信息甄别**”或“**机制设计**”）和提供信息（“**信号显示**”或“**信号传递**”）。优势一方通过一种**有成本**的手段向处于劣势的一方传递自己的真实信息比如免费保修和打广告
  - **声誉机制或信誉机制**

- **品牌价值**

  - 信息越不对称，**品牌价值**越大。土豆信息不对称程度低，所以没有品牌
  - **竞争优势**：
    - 成本优势：价格下限
    - 产品优势：质量功能等
    - 品牌优势：消费者的信任，节约消费者收集信息的成本
  - **技术进步**：导致信息不对称加大
  - **收入水平**：富人有更高的购买力，愿意支付品牌溢价；获取信息的机会成本更高，愿意花钱买信任

- **非市场机制**

  - 政府管制：反垄断、解决外部性、解决信息不对称
    - 政府无所不知
    - 官员大公无私
    - 政府说话算数
  - 非营利性组织

- **政府管制和市场信誉**
  两个解决信息不对称的基本机制，有一定的**替代性和补充性**

  - 管制和信誉的关系：相交和不相交
  - 破坏声誉机制的可能
    - 管制导致企业家预期不稳定和短期行为
    - 管制导致垄断，使市场惩罚不可信
    - 管制导致腐败和寻租行为，依靠政府关系比建立品牌更有利可图

**信号传递机制**（用可信的方式显示自己的类型）

- **信号传递成本**：高能力的的人和低能力的人有不同的成本
  通过贝叶斯法则判断类型
- **分离均衡**：$QC \le P-p \lt qC$
  - 激励相容约束：好车有积极性提供保修；坏车没有积极性提供
  - 理性参与约束：无论好车坏车，卖主愿意出售，买主愿意购买
- **广告的信号传递作用**
  - **产品信息不对称程度**
    - 搜寻品：事前不知道，但付出一定成本后可以知道
      广告提供直接信息：材料、做工、价格、地点等
    - 经验品：使用过后才知道
      做广告意味着高质量，广告费是向市场传递信息的成本
    - 信任品：使用后也不知道
      广告不一定能传递信息，需要长期积累的声誉
- **资本市场中的信号传递**
  - 好企业提高自己的负债率，因为好企业破产几率低
  - **融资顺序理论**
    - 内部资金
    - 债券融资（对企业价值不敏感）
    - 股权融资（受企业经营情况影响），选择信息不对称情况低的时候发行
- **生活中的信号传递**
  - **累赘原理**
  - 送礼
    - 双方都要送礼，但价值将相互抵消
    - 毁灭价值，成本必须大于价值
    - 送礼物，不送现金
    - 送别人自己不会买的东西最合适。
