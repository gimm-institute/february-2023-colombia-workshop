
# Credit risk

![[title-page.md]]

$$
\newcommand{\xrl}[t]{\mathit{r}_{L,#1}}
\newcommand{\xrd}[1][t]{\mathit{r}_{D,#1}}
\newcommand{\xrbench}[1][t]{r^\star_{#1}}
\newcommand{\xlgd}{\lambda}
\newcommand{\xclr}[1][t]{q_{#1}}
\newcommand{\xE}[1]{\mathrm{E}_t\!\Bigl[ #1 \Bigr]}
\newcommand{\xrepay}[1][t]{\theta}
\newcommand{\xfixl}{\psi_L}
\newcommand{\xshock}{\epsilon}
\newcommand{\xnewrl}[1][t]{\mathit{r}^\Delta_{L,#1}}
\newcommand{\xnewrlfull}[1][t]{\mathit{r}^{\Delta\mathrm{full}}_{L,#1}}
\newcommand{\xnewrlpart}[1][t]{\mathit{r}^{\Delta\mathrm{part}}_{L,#1}}
\newcommand{\xdiscx}[2]{\delta^{\star}_{#1, #2}}
\newcommand{\xdiscxfull}[2]{\delta_{#1, #2}^{\star\mathrm{full}}}
\newcommand{\xdiscxpart}[2]{\delta_{#1, #2}^{\star\mathrm{part}}}
\newcommand{\xDISCx}[1][t]{\Delta_{#1}^{\star}}
\notag
$$

--------------------------------------------------------------------------------


## Feedback through credit risk

Credit risk creates several feedback loops and linkages in the model:

* Current credit events impair loan performance: allowances, write-offs, losses, capital deterioration

* Expected credit risk gets priced in new lending rates/conditions

* Capital adequacy stress gets priced in new lending rates/conditions

* Unexpected risk (i.e. value at risk between expected risk and a particular percentile) is buffered in regulatory capital

* Macro conditions trigger credit events: nonlinear mapping of current and expected macro conditions into credit events



## Summary of credit risk feedback elements



| Credit risk feedback element              | Module |
|---                                                |---            |
| Credit events $\rightarrow$ Loan performance | Bank loan performance |
| Expected risk $\rightarrow$ Lending conditions | Bank interest rates |
| Capital adequacy stress $\rightarrow$ Lending conditions | Bank capital |
| Macro conditions $\rightarrow$ Credit events   | Credit risk connector |
| Lending conditions $\rightarrow$ Output and forex | Local macro economy |


--------------------------------------------------------------------------------


## Expected and unexpected losses


* Allowances (contra-asset) to cover expected losses (mean values)

* Capital (equity) to cover so-called unexpected losses



--------------------------------------------------------------------------------


## Lending spreads, credit risk and allowances


In theory, the expected credit losses are covered fully by the lending
spread if priced correctly $\to$ allowances would not be needed.


In the real world

* Lending spreads are far from being priced to fully/perfectly accommodate true risk: partly mismeasurement/misjudgment, partly a deliberate choice by banks (strategic behavior)

* Fixed rate loans cannot be repriced with new information arriving and expected loss revisions

* Observed (market) lending rates do not sufficiently compensate for expected credit losses


--------------------------------------------------------------------------------


## Lending rates in real world

New lending rates affected by the anticipation of three types of risks

* **Interest rate risk**: today's and future changes in short term rates
  may make the funding costs of fixed rate contracts increase

* **Borrower credit risk**: today's and future credit events (changes in
  frequency of) may reduce profits from the contracts

* **Bank capital adequacy risk**: today's and future likelihood of
  regulatory capital shortfall, capital stress


For a number of reasons, these two types of risks are not always passed
through on to lending rates fully.

The observed lending rates typically only reflect the anticipated risks
partially.

The remaining part of the risk (that is not priced in the lending rates) is
expressed in (unobservable) new non-price lending conditions.



--------------------------------------------------------------------------------


## Credit risk function


* Implicitly based on Basel asymptotic single risk factor approach

* Mapping from a macro conditions index, $z_t$, (a single composit factor) into
  a portfolio default rate, $q_t$

$$
q_t = f(z_t)
$$

<br/>

* Sign and location conventions for $z_t$:

| Value | Meaning |
|---|---|
| $z_t=0$ | Macroeconomic and macrofinancial steady state |
| $z_t>0$ | Better than average times | 
| $z_t<0$ | Worse than average times |


--------------------------------------------------------------------------------


## Role of credit risk in the model


* Actual performance of the existing loan portfolio

* Expected credit risk used in pricing new loans


--------------------------------------------------------------------------------


## Key conceptual properties of credit risk function


* Nonlinear and asymmetric

* Around normal times, the credit risk function can be safely approximated
  as a linear function

* Large distress leads to disproportionately larger deterioration in loan
  performance

* Conversely, exceptionally good times reduce defaults to a much smaller
  extent


--------------------------------------------------------------------------------


## Functional form


* Five-parameter generalized logistic function

$$
f(z_t) \equiv
\underline q + \left(\overline q - \underline q\right) \left[ \frac{1}{1 + \exp-\frac{z-\mu}{\sigma} } \right]^{\exp\nu}
$$


| Parameter | Meaning |
|-----------|---------|
| $\mu$ | Location: moves the curve left-right |
| $\sigma$ | Scale: makes the curve steeper/flatter |
| $\nu$ | Shape: makes the curve asymmetric |
| $\underline q$ | Lower bound |
| $\overline q$ | Upper–lower bound spread |


--------------------------------------------------------------------------------

## Macro conditions index


The portfolio segment specific macro conditions index combines

* current macro performance: output gap

* borrower vulnerability: annualized credit (loans) to GDP ratio


Constructed in deviations from the long-run sustainability trends

$$
z_t^k \ =\ 
\left( \log y_t - \log \overline y_t \right)
\ - \ c_1 \left( 
\left[ \tfrac{l^k}{4 \ py \ fwy} \right]_t 
- \overline{\left[ \tfrac{l^k}{4\ py \ y}\right]}_t
\right)
$$


--------------------------------------------------------------------------------


