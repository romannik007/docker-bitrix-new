
Выполнять в следующей последовательности:

**Сразу можно приступать с пункта 7, так как образ загрузится из https://hub.docker.com**

1. **build.sh**  - (запускать 1 раз если все нормально без ошибок на экране) для установки  «1С-Битрикс: Веб-окружение» - Linux (BitrixEnv) - стандартный скрипт со страницы https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=37&LESSON_ID=8811
2. Сменить пароль для пользователя bitrix - это формальность, так как build.sh используется только для установки софта
3. **выполнить** установоку push&pull nodejs через меню - это 9 пункт (обязательно дождаться установки. Процесс можно наблюдать в top или в пунктах меню)
4. **выйти** из контейнера
5. **commit.sh** - для создания образа из контейнера с установленной средой (впоследствии из него запускаем новый контейнер с пробросом нужных папок)
6. **Теперь** образ необходимо поместить в реестр или сохранить в файл коммандой 
   
   ```
   docker save -o bitrix-base-new
   ```
   
   и затем его восстановить
   
   ```
   docker load -i bitrix-base-new
   ```

7. **пункты с 7 по 10 только для linux** 
   **Чтобы** работало редактирование файлов в проекте и на хосте и в контейнере:
   - исправляем файл или создаем /etc/docker/daemon.json:
      
      ```al
      {
          "userns-remap": "<свое имя пользователя в системе>"
      }
      ```

      **пример**: у меня пользователь user2
      
      ```al
      {
          "userns-remap": "user2"
      }
      ```

  
   - в /etc/subgid и /etc/subuid
      
      *<свое имя пользователя в системе>:<ID>:65536*

      где *<ID> = id* пользователя в системе минус id пользователя bitrix в контейнере (почти всегда 600)

      **пример**: у меня пользователь user2 uid=1000 и gid=1000
                 
         /etc/subuid
            user2:400:65536 
                     
         /etc/subgid
            user2:400:65536 


   **Также необходимо выполнить**
   https://sylabs.io/guides/3.8/admin-guide/user_namespace.html#user-namespace-requirements

   Debian   

      ```bash
      sudo sh -c 'echo kernel.unprivileged_userns_clone=1 \
          >/etc/sysctl.d/90-unprivileged_userns.conf'
      sudo sysctl -p /etc/sysctl.d /etc/sysctl.d/90-unprivileged_userns.conf
      ```

   RHEL/CentOS 7

      From 7.4, kernel support is included but must be enabled with:


      ```bash
      sudo sh -c 'echo user.max_user_namespaces=15000 \
          >/etc/sysctl.d/90-max_net_namespaces.conf'
      sudo sysctl -p /etc/sysctl.d /etc/sysctl.d/90-max_net_namespaces.conf
      ```

            
         
8. ```
   sudo service docker restart
   ```
   
   (все контейнеры и образы, созданные под предыдущим uid и gid, не будут видны)
9.  ```
    mkdir -m 777 -p ./bitrix/mysql
    ```
10. ```
    docker-compose up -d --build --force-recreate
    ```
11. Прописываем данные для поключения к шаре windows в файле .env
12. ```
    docker-compose -f docker-compose-smb.yml up -d --build --force-recreate
    ```
13.  **копируем** bitrixsetup.php из в папку ./bitrix/www или восстанавливаем свой проект.
    
      ```
      chmod -R 777 bitrix/www
      ```

      в windows нет необходимости выпонять
      

14.  **Если установка производится из скрипта bitrixsetup.php, то после установки сайта подменяем .settings.php из bitrix/bitrix-set/, пункты  13 и 14  не выполняем.**
      Данные для подключения к БД пописаны в .env
      
15. **входим** в вэбку http://127.0.0.1/bitrixsetup.php 
16. в файле .settings.php в проекте прописываем данные для соединения с БД и ключ вставляем такой: 

      *'signature_key' => 'bVQdNsrRsulOnj9lkI0sPim292jMtrnji0zzEl5MzCBeHT7w1E5HL3aihFb6aiFJfNEIDxmcFrowS3PTLZFDxAfuNNuCN5EcFRaveaUaRZHSThtWKV7Vp5vGbz9kb3cN'*

      пример .settings.php в папке bitrix/bitrix-set/

      **Настройки в новом ядре выполняются в файле /bitrix/.settings.php. Напомним, что в старом ядре аналогичные настройки выполнялись в файле /bitrix/php_interface/dbconn.php. Файл .settings.php структурно сильно отличается от прежнего dbconn.php.**

      **Если push&pull не работает, необходимо пересохранить настройки в модуле push&pull выбрав 2 пункт  и потом 4-й**



**Дополнительно**:
- в файле .env содержатся данные для подключения к mysql,
  логин и пароль пользователя bitrix из env используем только при чистой установке битрикс
- в папках **bitrix/apache, bitrix/nginx-config, bitrix/php** содержатся файлы для кастомных настроек
- логи apache, nginx и cron в папке bitrix/logs
- адрес сервера БД - **mysql** (указываем для подключения)
- commit_push - для создания образа из контейнера с установленной средой и push в нужный реестр
- запуск только первый раз
  ```
  docker-compose up -d --build --force-recreate
  ```  
  далее уже запускаем 
  ```
  docker-compose up -d
  ``` 
  или 
  ```
  docker-compose start
  ```  
   (вэбка доступна по порту 80 или 443, mysql - 3306)

- подключиться к контенеру в баш )
   ```
   docker exec -ti <сервис> /bin/bash
   ``` 


