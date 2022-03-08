#! /bin/bash


	zenity --notification 



	zenity --question \
	--text="Running a presearch node requires Docker, would you like to install Docker?"

	if [ $? -eq "0" ]; then
	sudo curl -sSL https://get.docker.com/ | sh && \
	zenity --notification \
	--text="Docker was installed succesfully, proceeding to presearch node installation" || \
	zenity --question --text="Docker could not be installed"
	fi

#Creating Docker

	zenity --question \
	--text="Running a pre-search node requires a presearch account, do you have an existing account?"
	if [ $? -eq "1" ]; then
	zenity --notification --text="A browser window with the presearch account registration page will appear shortly,"
	https://nodes.presearch.org/login
	fi

	YOUR_REGISTRATION_CODE_HERE=$(zenity --entry \
				--title="$helper $versnum" \
				--text="Please enter the your node registration code")
docker stop presearch-node ; docker rm presearch-node ; docker stop presearch-auto-updater ; docker rm presearch-auto-updater ; docker run -d --name presearch-auto-updater --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock presearch/auto-updater --cleanup --interval 900 presearch-auto-updater presearch-node ; docker pull presearch/node ; docker run -dt --name presearch-node --restart=unless-stopped -v presearch-node-storage:/app/node -e REGISTRATION_CODE=$YOUR_REGISTRATION_CODE_HERE presearch/node ; docker logs -f presearch-node
	zenity --notification --text="Your node should now be running" || \
	zenity --notificaton --text="An error occured during the onboarding process"

	zenity --notification --text="Would you like to see the nodes current output?"
		if [ $? -eq "0" ]; then
		docker logs -f presearch-node
		fi


