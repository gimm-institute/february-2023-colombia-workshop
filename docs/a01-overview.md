
# Overview of the framework

![[title-page.md]]


---


## What is the framework for?

* Big-picture description of two-way interactions between macro and the
  banking system with endogenous feedbacks

* Support for macroprudential policy analysis; focus on individual
  macroprudential policy interventions

* Scenario analysis with explicit assumptions

* Complement (not substitute) to other existing models/tools

* Synthesize a variety of insights and inputs, including expert judgment

* Focus on the asset side (asset performance)


---


## What is the framework **not** for?

* Forecasting framework

* Formal probabilistic model or statistical prediction framework

* Deeply structural (aka DSGE) model

* Analyze endogenous macroprudential policy  (unlike monetary policy
  models)


---


## Use cases and place in financial stability frameworks

*After we see the structure of the model*

---

## Basic structure of the framework

* Modular design (highly customizable) rather than fixed form
* The very basic model framework consists of three types of modules: macro, banking system, and connecting modules

![Model structure](model-structure.png)


---


## Brief description of main modules

| File name in `+model`         | Description   |
|---                            |---            |
| `macro.model`         | Concise description of the macroeconomy: real economic activity (GDP, potential, gap), price level (CPI, deflator), monetary policy, short-term money market rate, exchange rate |
| `creditCreation.model` | Demand for new loans, responding to lending conditions and macro activity, loans to GDP ratio |
| `creditRisk.model`          | Macroeconomic conditions index; nonlinear mapping from macro conditions index to portfolio default rates |
| `interestRate.model`       | Setting of new lending and new funding rates by banks, time evolution of stock lending and stock funding rates |
| `loanPerformance.model`   | Performing, nonperforming loans; gross, net loans; allowances for losses, write-offs |
| `bankCapital.model`       | Internal and external flows of capital, components of profit/loss, regulatory capital indicators and policies |



## Semi-structual approach to modeling

* Top-down model building strategy - look at the financial system as a
  whole, describe the aggregate behavior, big picture interactions between
  macroeconomy and financial sector

* Explicit (but not _microfounded_) concepts of supply and demand
  (aggregate, credit, etc.): framework closely follows
  theoretically-consistent models, but deviates where necessary for
  tractability and operability

* Unobserved sustainability trends, similar to (unobserved) potential
  output or equilibrium real interest rate in other models

* Explicit forward-looking (model-consistent) endogenous expectations,
  impact of the anticipation status of future events (anticipated vs
  unanticipated shocks, pre-announced vs suprise policy actions)

* Well-behaved steady-state (growth path)


* When parameterizing the model, the properties of the model as a whole system matter

* Simple recursive processes to approximate complex real-life dynamics (loan repayment schedule, present value calculations, asset valuation)

## Stylized flowchart of main macro-financial feedback linkages


---


![Stylized flowchart of main macro-financial feedback linkages](feedback.png)

## Operational flexibility

* Not a traditional econometric model with fixed form

* Needs to be maintained as a live evolving project, reacting to needs and
  questions arising over time

* Some equations and parameters may change as part of scenario assumptions


---


## Typical use cases

1. Data-based projections, scenarios consistent with macroeconomic
   assumptions (e.g. central bank macro forecast) and the current state of
   the financial sector

1. Delta method to build scenarios on top of a baseline: consistent picture
   of shock impact on the macroeconomy and financial sector, taking into
   account the current state of the financial sector

1. Interpret historical/recent data (shocks, counterfactuals,
   unobservables)

1. Conceptual simulations, in particular policy interventions simulations,
   to recive insights as to how a particular policy impacts the financial
   sector and macroeconomy


---

To add

* Aggregative
* Financial system = banking system in the basic version, extensions: securities dealers, nonbank intermediaries, large corporate securities markets
* Medium-term risks to solvency
* Dynamic portfolio, "behavioral" response
* Two-way interactions
* Justification for macroprudential
* Highly country specific (accounting, regulatory, reporting standards)
