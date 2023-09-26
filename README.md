# larsoft

This code is part of the Liquid Argon Software (LArSoft) project.
It contains simulation and reconstruction algorithms for LAr TPC detectors.
If you have a problem, please log a redmine issue: https://cdcvs.fnal.gov/redmine/projects/larsoft/issues/new

See the [LArSoft wiki](https://larsoft.github.io/LArSoftWiki/)

larsoft is an umbrella product used to setup all larsoft products.

## Dependencies

```
larsoft
|__larana
|  |__larreco
|     |__larsim
|     |  |__larg4
|     |  |  |__larevt
|     |  |  |  |__lardata
|     |  |  |  |  |__larcore
|     |  |  |  |  |  |__larcorealg
|     |  |  |  |  |     |__larcoreobj
|     |  |  |  |  |__lardataalg
|     |  |  |  |  |  |__lardataobj
|     |  |  |  |  |__larvecutils
|__lareventdisplay
|__larexamples
|__larpandora
|  |__larpandoracontent
|__larrecodnn
|__larsimdnn
|__larsimrad
|__larsoftobj
|__larwirecell
```

