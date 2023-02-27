
# Lending and funding rates

$$
\newcommand{\loan}{l}
\newcommand{\xnewrl}[t]{rl^\Delta_{#1}}
\newcommand{\xnewrd}[1][t]{rd^\Delta_{#1}}
\newcommand{\xnewrlone}[1][t]{rl^{\Delta s1}_{#1}}
\newcommand{\xrl}[1][t]{rl_{#1}}
\newcommand{\xrd}[1][t]{rd_{#1}}
\newcommand{\xrs}[1][t]{\mathit{rs}_{#1}}
\newcommand{\psirl}{\psi_{rl}}
\newcommand{\lp}[1][t]{\loan p_{#1}}
\newcommand{\lpo}[1][t]{\loan p^0_{#1}}
\newcommand{\newl}[1][t]{\loan^\Delta_{#1}}
\newcommand{\xbase}{\mathrm{base}}
\newcommand{\xicr}{\mathrm{icr}}
\newcommand{\xnewrlbase}[1][t]{rl^{\Delta\xbase}_{#1}}
\newcommand{\xnewrdbase}[1][t]{rd^{\Delta\xbase}_{#1}}
\newcommand{\xnewrlicr}[1][t]{rl^{\Delta\xicr}_{#1}}
\newcommand{\xpvcbase}[1][t]{pvc^\xbase_{#1}}
\newcommand{\xpvxbase}[1][t]{pvx^\xbase_{#1}}
\newcommand{\xpvpbase}[1][t]{pvp^\xbase_{#1}}
\newcommand{\xpvnbase}[1][t]{pvn^\xbase_{#1}}
\newcommand{\xfcy}{\mathrm{fcy}}
\newcommand{\xlcy}{\mathrm{lcy}}
\newcommand{\xrlapm}[1][t]{rl_{#1}^\mathrm{apm}}
\newcommand{\xpsirl}[1][t]{\psi_{rl}}
\newcommand{\xapm}{\mathrm{apm}}
\newcommand{\xfull}{\mathrm{full}}
\newcommand{\xnewrlfull}[1][t]{rl^{\Delta\xfull}_{#1}}
\newcommand{\xss}{\mathrm{ss}}
\notag
$$



## Stock-flow dynamics in lending rates



![Stock-flow dynamics in lending rates](lending-rates-stock-flow.png)



### Stock-flow relationship in lending rates

Each period, a lending rate on newly issued credit ("new lending rate") $\xnewrl[t]$ is determined by the banks based on a cost-plus loan pricing mechanism described below. The new lending rate then applies to a certain proportion, $\psirl$, of the stock of pre-existing outstanding loans (i.e. these loans are repriced), and to all new loans. This is to mimick the fact that the total loan portfolio comprises loan contracts with different interest fixation periods. The duration of interest fixation differs in general, from the duration of the respective individual loans themselves. Depending on the parameter $\psirl$, we can choose any point between the following two limit cases to describe the average lending rate fixation period within a portfolio segment:

* $\psirl=0$: the duration of the lending rate fixation matches exactly the duration of the underlying loan (a **fixed rate** loan) for each loan in the portfolio
  
* $\psirl=1$: the lending rate is fully adjustable on the underlying loan (an **adjustable rate** loan) for each loan in the portfolio

The effective rate that determines the interest income on the stock of outstanding loans, called the stock lending rate, $\xrl$, is given by
$$
\xrl = 
\xrl[t-1] + \
\Omega_{t}\ ( \xnewrl[t] - \xrl[t-1] )
+ \epsilon_{\xrl[],t}
$$

where $\Omega_{t} \in \left(0, \ 1 \right]$ is a (time-varying) share of new lending rates in the updated effective stock rates

$$
\Omega_{t} = \frac{ \psirl \, (1-\theta) \, \lpo + \newl}{\lp}
$$

and is given by the proportion of the performing loan portfolio, $\lp$, to which the new rate applies, consisting of a $\psirl$ fraction of the existing loans and all
the new loans.



## Forward-looking cost-plus loan pricing



![Forward-looking cost-plus loan pricing](new-lending-conditions.png)



### Forward-looking cost-plus loan pricing


The new lending rates respond to four components of bank costs

| Cost components |
| ------------------------------------------------------------ |
| Marginal funding cost including short rate risk over LRF[^1] |
| Borrower credit risk premium over LRF[^1] |
| Endogenous profit margin to cover cost of bank capital (balance sheet stress) |
| Autonomous profit margin to cover other unmodeled cost drivers |

[^1]: Lending rate fixation



### Expected funding costs depending on lending rate fixation

The lending rate fixation period is approximated at a portfolio segment level using the average lending rate fixation period $\xpsirl$.



##### Short-term base rate

The short term base rate comprises

* the marginal cost of funding liabilities, $rs_t$
* the cost of bank capital, $rx_t$
* an autonomous profit margin, $rl_t^{\Delta\xapm}$



$$
% \xnewrlbase = (1-\sigma) \ \xrs^\xlcy + \sigma \ \xrs^\xfcy + rx_t
% \xnewrlbase = \xrs + rx_t + rl_t^{\Delta\xapm}
\xnewrlbase = \xrs +  rl_t^{\Delta\xapm}
$$

For dollarized loan segments, we take into account both LCY and FCY funding costs:
$$
rs_t = (1-\sigma) \ \xrs^\xlcy + \sigma \ \xrs^\xfcy
$$



##### Forward-looking rate covering credit risk

The hypothetical lending rate covering the full credit is given by
$$
rl^{\Delta \xfull,1}_t = 
(1-\Psi_1)\ \left[ 
\frac{1 + rl_t^{\Delta\xbase}}{1 - \lambda \ q_{t+1}}
\ +\ \Psi_1\ \frac{1 + rl_{t+1}^{\Delta\xbase}}{1 - \lambda \ q_{t+2}}
\ +\ \Psi_1^2\ \frac{1 + rl_{t+2}^{\Delta\xbase}}{1 - \lambda \ q_{t+3}}
+ \ \cdots\ 
\right] + \epsilon^{rl\Delta\xfull, 1}_t
$$



where
$$
\Psi_1 = \left( 1 - \psi_{rl,1} \right) \left( 1 - \theta \right)
$$

is the effective discount factor applied on each future base cost



**Forward-looking rate covering cost of bank capital**

The cost of bank capital (capital shortfall stress) is also reflected in loan pricing given by
$$
rl^{\Delta \xfull,2}_t = 
(1-\Psi_2)\ \left[ 
(1 + rx_t)
+\ \Psi_2 (1 + rx_t)
+\ \Psi_2^2\ (1 + rx_{t+2})
+ \ \cdots\ 
\right] + \epsilon^{rl\Delta\xfull, 2}_t
$$




**Forward-looking weighted average**

Overall hypothetical lending rate reflecting all costs is given by
$$
1 + rl^{\Delta \xfull}_t = (1 + rl^{\Delta \xfull,1}_t) \cdot (1 + rl^{\Delta \xfull,2}_t)
$$


##### Price and non-price lending conditions

The hypothetical full-cost rate $rl^{\Delta \xfull}_t$ splits into

* a price component, i.e. the actually observed new lending rate;

* non-price conditions measured by an interest rate equivalent and passed on to borrowers)

    

The extraction of the price component is based on the spread over the base rate. Parameter $c_1$ controls what share of risk is reflected in the price components as opposed to the non-price conditions:

$$
\xnewrl = \xnewrlbase \
+\ c_1 \left( \xnewrlfull - \xnewrlbase \right)
+\ \left(1-c_1\right) \left( \xnewrlfull[\xss] - \xnewrlbase[\xss] \right)
$$



The hypothetical full-cost rate $\xnewrlfull$ enters the aggregate demand and credit demand equations, as it represents the true cost of credit for borrowers. 

The observed lending rate $\xnewrl$ enters the bank profits calculations.



## Stock-flow relationship in funding rates

The effective rate that determines the interest expense on the stock of
non-equity liabilities, called the stock funding rate, $\xrd$, is given by
$$
\xrd = 
\xrd[t-1] + 
\psi_{rd} \ ( \xnewrd[t] - \xrd[t-1] )
+ \epsilon_{\xrd[],t}
$$

where $\psi_{rl} \in \left(0, \ 1 \right]$ is the effective impact of new funding rates on the stock rates, and is parameterized as an exogenous number.



## New funding rates

The new funding rates are set as a markdown (with a parameterized autonomous profit margin, $rd^\mathrm{apm}$) below the short-term cash rate (averaged across the currencies of denomination)
$$
\xnewrdbase = rs_t - rd^\xapm_t
+ \epsilon_{rd\Delta, t}
$$

$$
rs_t = (1-\sigma) \ \xrs^\xlcy + \sigma \ \xrs^\xfcy
$$



---



