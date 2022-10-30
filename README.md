
## Тестовое задание на позицию стажера - WorkersList project 



Приложение состоит из одного экрана с использованием UITableView. На этом экране расположен список из сотрудников Авито, их имен, номеров телефонов и навыков. Все данные передаются через Api call, для запроса данных используется URLSession. Также приложение работает на iOS 13 и выше.


Приложение доступно как на iPhone, так и на iPad

<p align="center" width="100%">
    <img width="23%" src="https://user-images.githubusercontent.com/111228178/198905039-920c5ae6-845e-46fb-a3f2-f903e0198520.jpg">
     <img width="37%" src="https://user-images.githubusercontent.com/111228178/198904608-199820e6-179b-4119-b0e1-9bfe22a51c48.png">
</p>

Также список отсортирован по алфавиту 


```swift
 self?.employees = workersList.company.employees.sorted { employeelhs, employeerhs in
                    
                    employeelhs.name < employeerhs.name
                }
```

Все настройки UI части выполнены внутри кода. К исходным данным были добавлены картинки, а также SF Symbol, в виде перечекнутого значка вай фая, он появляется при условии, что телефон не подключен к сети интернет. 
Также при потери итернета всплывает увeдомление, которое показывает пользователю, что пропало соеденинение 
```swift
 private func showAlert() {

        let alert = UIAlertController(title: "No Internet", message: "This app requires wifi/internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        present(alert, animated: true, completion: nil)
    }
```
<p align="center" width="100%">
    <img width="30%" src="https://user-images.githubusercontent.com/111228178/198905040-0828a27a-6ac6-4326-85af-93a9cdc1acd1.jpg">
     <img width="30%" src="https://user-images.githubusercontent.com/111228178/198905042-db5a69f6-a30d-449a-8eb0-532273e72989.jpg">
</p>

В приложение настроено кэширование. После того, как мы загрузили данные, в течении следующего часа данные не обновляются, а просто загружаются кэшированные данные 
```swift
func fetchResultsFromApi(completion: @escaping (Result<WorkersList, Error>) -> Void) {
        
        if let lastDataRequestTime {
            
            let currentDate = Date()
            let timeIntervalInSeconds = currentDate.timeIntervalSince(lastDataRequestTime)
            
            if timeIntervalInSeconds > 3600 {
                requestRemoteData(policy: .reloadIgnoringCacheData, completion: completion)
            } else {
                requestRemoteData(policy: .returnCacheDataElseLoad, completion: completion)
            }
            
        } else {
            requestRemoteData(policy: .reloadIgnoringCacheData, completion: completion)
        }
    }
```



