#!/bin/bash

env="$1"

if [[ $env == 'prod' ]]; then
	#production paths
	server1_path='/home/upc1/MyProj/RND/Pm2Rnd/server-1/index.js';
	server1_log_path='/home/upc1/MyProj/RND/Pm2Rnd/server-1/log.txt';
	server1_error_log_path='/home/upc1/MyProj/RND/Pm2Rnd/server-1/err-log.txt';

	server2_path='/home/upc1/MyProj/RND/Pm2Rnd/server-2/index.js';
	server2_log_path='/home/upc1/MyProj/RND/Pm2Rnd/server-2/log.txt';
	server2_error_log_path='/home/upc1/MyProj/RND/Pm2Rnd/server-1/err-log.txt';
else
	#devlopment paths
	echo ""
fi

#scanning module commands
scanning(){
	echo "Commands available for Scanning Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $server1_path --name server1 -o $server1_log_path -e $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop server1
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete server1
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload server1
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server2_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

#other module commands
other(){
	echo "Commands available for Other Module";
	select yn in "PM2-log-rotate-100-mb"; do
    	case $yn in
		#rotate logs at 100 mb and enable compression
        PM2-log-rotate-100-mb )
         	command -v pm2 >/dev/null 2>&1 || { echo >&2 "Enabling log rotate for pm2 requires pm2 to be installed. Pm2 wasn't found on this system. Aborting."; exit 1; }
			pm2 set pm2-logrotate:max_size 100B
			pm2 set pm2-logrotate:compress true
			echo "SUCCESS. Log rotate is set to be performed at 100MB file size."
         	break;;        
    	esac
	done
}

#All module commands
all(){
	echo "Commands available for All Module";
	select yn in "Start" "Stop" "Restart" "Delete"; do
    	case $yn in		
        Start )
			#insert below start commands for all pm2 processes which you wish to start
         	pm2 start $server1_path --name server1 -l $server1_log_path
         	break;;        
		Stop )
			pm2 stop all
			break;;        
		Restart )
			pm2 reload all
			break;;        
		Delete )
			pm2 delete all
			break;;        
    	esac
	done
}

#Bag Tracking commands
submission(){
	echo "Commands available for Scanning Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $server1_path --name server1 -o $server1_log_path -e $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop server1
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete server1
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload server1
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server2_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

#Bag tracking commands
bugTracking(){
	echo "Commands available for Scanning Module";
	select yn in "Start" "Stop" "Reload" "Delete" "Status" "Error-logs-real-time" "Error-Logs-100-Lines" "Normal-logs-real-time" "Normal-Logs-100-Lines"; do
	    case $yn in	        	        	        
			Status )
				pm2 status				
				break;;
			Start )
				if [[ $env == 'prod' ]]; then
					pm2 start $server1_path --name server1 -o $server1_log_path -e $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			Stop )
				if [[ $env == 'prod' ]]; then
					pm2 stop server1
				else
					echo "no command"
				fi
				break;;
			Delete )
				if [[ $env == 'prod' ]]; then
					pm2 delete server1
				else
					echo "no command"
				fi
				break;;
			Reload )
				if [[ $env == 'prod' ]]; then
					pm2 reload server1
				else
					echo "no command"
				fi
				break;;
			#realtime error logs
			Error-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --err
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines of error log
			Error-Logs-100-Lines )				
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server1_error_log_path
				else
					echo "no command"
				fi
				break;;
			#realtime logs
			Normal-logs-real-time )
				if [[ $env == 'prod' ]]; then
					pm2 logs --lines=100 --timestamp="YYYY-MM-DD HH:mm:ss Z" server1 --out
				else
					echo "no command"
				fi
				break;;
			#get last 100 lines log
			Normal-Logs-100-Lines )
				if [[ $env == 'prod' ]]; then
					tail -n 100 $server2_error_log_path
				else
					echo "no command"
				fi
				break;;			
	    esac
	done
}

echo "Modules available"
select yn in "Scanning" "QC" "Bag-Tracking" "Submission" "Other" "All"; do
    case $yn in
        Main )
         	scanning
         	break;;        
		Bag-Tracking )
			bugTracking
			break;;
		Submission )
			submission
			break;;
		All )
			all
			break;;
		Other )
			other
			break;;
    esac
done