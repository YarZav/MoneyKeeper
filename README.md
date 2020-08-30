# MoneyKeeper

IOS application to get cash information.

## Folder's structure

```bash
- MoneyKeeper.xcdatamodeld                          (CoreData structure)

- AppDeleate                                        (AppDelegate, AppDependencies with singleton, launching managers etc.)
    - AppDelegate.swift
    - AppDependencies.swift

- Managers                                          (All managers)
    - CoreDataManager.swift

- DataLayer                                         (Data models, DAO, Mapper for CoreDataModel->BusinessModel etc.)
    - DAO
        - DAO.swift
    - MyFirstModel
        - MyFirstModel+DAO.swift

    - Models
        - MyFirstModel
            - CoreDataModel
                - MyFirstCoreDataModel.swift
            - BusinessModel
                - MyFirstModel.swift
            - NetworkResponceModel
                - MyFirstNetworkReponceModel.swift

    - Mapper
        - ModelMapper.swift
        - MyFirstModelMapper
            - MyFirstModel+ModelMapping.swift

- ViperModels                                       (Viper modules and factory for Viper modules)
    - Resolver
        - DIResolver.swift
        - DIResolver+FirstViewController.swift

    - Modules
        - FirstViewController
            - FirstViewControllerInteractor.swift
            - FirstViewControllerPresenter.swift
            - FirstViewControllerViewController.swift
            - FirstViewControllerWireFrame.swift
            - FirstViewControllerProtocols.swift

- SupportingFiles                                   (Extensions for classes, subviews, components, images, info.plist etc.)
    - Extensions
        - Array+Extension.swift

    - Subviews
        - SomeSubview.swift

    - BaseComponents
        - SomeBaseNavigationComponent.swift

    - Assets.xcassets

    - Info.plist
```
