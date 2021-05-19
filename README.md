# eums

An `R` package for the European Union Member States (EUMS) Database. The database contains various data on EU member states, including variables about accession, the political system of the member state, participation in the European Economic and Monetary Union (EMU) and the Schengen Area, legal obligations and opt-outs, and membership in other international organizations. The database also includes data on qualified majority vote (QMV) weights and a template for cross-sectional time-series (CSTS) data on member states. 

## Installation

You can install the latest development version of the `eums` package from GitHub:

```r
# install.packages("devtools")
devtools::install_github("jfjelstul/eums")
```

## Documentation

The codebook for the database is included as a `tibble` in the `R` package: `eums::codebook`. The same information is also available in the `R` documentation for each dataset. For example, you can see the codebook for the `eums::member_states` dataset by running `?eums::member_states`.

## Citation

If you use data from the `eums` package in a project or paper, please cite the `R` package:

> Joshua Fjelstul (2021). eums: The European Union Member States (EUMS) Database. R package version 0.1.0.9000.

The `BibTeX` entry for the package is:

```
@Manual{,
  title = {eums: The European Union Member States (EUMS) Database},
  author = {Joshua Fjelstul},
  year = {2021},
  note = {R package version 0.1.0.9000},
}
```

## Problems

If you notice an error in the data or a bug in the `R` package, please report it [here](https://github.com/jfjelstul/eums/issues).
