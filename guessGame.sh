#!/bin/bash

#Select 3 band members logic
selectBandMembers() {
    while true
    do
    #displaying band member options
    echo "Select 3 of from the 5 band members of previous bands"
    echo "
    +====+=================+
    |CODE|Star Band Members|
    +----+-----------------+
    |JL  |John Lennon      |
    |AY  |Angus Young      |
    |FM  |Freddie Mercury  |
    |DH  |Debbie Harry     |
    |KC  |Kurt Cobain      |
    +====+=================+
    "
    echo "Use the following format: "
    echo "Members: FM DH KC (for Freddie Mercury, Debbie Harry, and Kurt Cobain)"
    echo
    read -p "Members: " memb1 memb2 memb3 memb4; echo

    #validating member selection
    found1=0
    found2=0
    found3=0

    for var in JL AY FM DH KC
    do
        if [ "$memb1" == $var ]
        then
            ((found1++))
        elif [ "$memb2" == $var ]
        then
            ((found2++))
        elif [ "$memb3" == $var ]
        then
            ((found3++))
        fi
    done

    #predicting user input and providing appropirate outputs
    totalFound=$(($found1+$found2+$found3))

    #when exactly 3 correct members code
    if [ $totalFound -eq 3 ]
    then
        member1=$memb1
        member2=$memb2
        member3=$memb3
        echo "You selected:"
        break

    #when less than 3 correct member code (members repeating)
    elif [ $totalFound -lt 3 -a $totalFound -gt 0 ]
    then
        echo "Please enter code of 3 different band members"
        echo "try again  \(O w O)/"
        continue

    #when more than 4 inputs
    elif [ ! -z "$memb4" ] 
    then
        echo "Please enter only three band members"
        echo "try again   ~(T 3 T)~"

    #when 0 member codes are correct
    else
        echo "Please use the given codes to select band members!! (T w T)"
        continue
    fi
    done
}

#faking loading for asthetics
loading() {
    sleep 1
    echo -n .
    sleep 1 
    echo -n .
    sleep 1 
    echo -en ."\n\n"
}

#Choose one member to view info
chooseOneMember() {
    PS3="Enter one of the three Band member code: "
    select member in $1 $2 $3
    do 
        if [ -z $member ]
        then
            echo -e "\nPlease select from one of the option"
            echo -e "Using the respective numbers (1,2,3)\n"
        else
            echo -en "\n\nYou've selected $member, Displaying $member file"
            loading

            #error message for non existing files
            if [ "$member" == "DH" ] || [ "$member" == "KC" ] 
            then
                echo "File on this band member is unavailable"
                echo -n "Taking user back to Band selection step"
                loading

                #returning to mainfunction
                mainFunction

                break
            else
                cat $member; echo
                break
            fi
        fi
    done
}

#Best band determination logic
bestBandGuess() {
    bestBandCorrect=false
    #Guessing best band till correct band is selected
    until [ $bestBandCorrect == true ] 
    do
    #best band input
    echo "Please guess my favourite band using their respective code."
    echo "  
    +====+=========+
    |CODE|Band Name|
    +----+---------+
    |BEA |Beatles  |
    |AD  |AC/DC    |
    |QUE |Queen    |
    |BLO |Blondie  |
    |NIR |Nirvana  |
    +====+=========+
    "
    read -p "your guess: " bestBand; echo

    #Checking the guess
    case $bestBand in
        #correct band code and answer
        QUE)
            echo "YES!! QUEEN is the best band!"
            echo
            echo "Queen was a popular british rock band of the 70s." 
            echo "they popularized glam rock and encorperated genres"
            echo "ranging from heavy metal to subtle jazz"
            echo
            bestBandCorrect=true
        ;;
        
        #correct band code but incorrect answer
        NIR | BEA | BLO | AD)
            echo "They are a good band, but not the best one"
            echo "Guess again!!  ~(^ W ^)~"
            echo
        ;;

        #incorrect band code
        *)
            echo "Plesase use the appropirate CODE assigned to the"
            echo "respective bands and try again!"
            echo
        ;;
    esac
    done
}

#Greetings
greetings() {
    clear
    echo Welcome user $username. Your ID is $ID.
    echo You accessed this program at:
    date 
    echo
}

#continue or not input
continueOrNot() {
    echo -e "\nDo you want to continue?"
    echo "[yes|no] options available"
    read -p "select option: " contd
}

#Main program
mainFunction() {
    while true
    do
        #Best band guessing
        bestBandGuess 

        #default 3 selected band
        member1=""
        member2=""
        member3=""

        #Selecting 3 star band members out of five
        selectBandMembers

        #Choose 1 member to display information
        chooseOneMember $member1 $member2 $member3

        #default continue status
        contd="yes"

        #taking user input for contuinity
        continueOrNot
        
        #program continuity
        if [ $contd == "no" ] 
        then
            break
        elif [ $contd == "yes" ]
        then
            clear
            continue
        else 
            echo "only 'yes' and 'no' are allowed"
            continueOrNot
        fi
    done

    #End note
    echo 
    echo "This program ends here  \(^ w ^)/"
    echo "Thank you for your time, have a nice day!!" 
}

#password checking
passwordCheck (){
    counter=0
    password=password123

    for chance in 3 2 1 
    do 
        echo "Enter the program password ( $chance remaining ):"
        read -s check 
        if [ $check == $password ] 
        then
            #greet the user first
            greetings
            #call main program
            mainFunction
            break
        fi
        #count incrementation
        ((counter++))

        #check no of attempts
        if [ $counter == 3 ] 
        then
        echo
        echo 'Your chance ends   ┐(^ W ^ )┌'
        echo 'Try again with correct password!'
        fi
    done
}

#Function calling starts from here with parameter checking 
if [ ! -z $1 ] && [ ! -z $2 ]
then
    if [ -z $3 ] 
        then 
        username=$2
        ID=$1  
        passwordCheck
    elif [ ! -z $3 ]
    then
        echo "This program accepts ID and Name parameters only  ┗(T o T)┓"
        echo
    fi
else
    echo "This program accepts ID and Name parameter  (╬T_T)"
    echo
fi