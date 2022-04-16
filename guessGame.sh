#!/bin/bash

#Select 3 band members logic
selectBandMembers() {
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

    #Adding transition delay between menu and example
    sleep 1

    #selection example provided to the user
    echo "
    +-------------+----------------------------------------+
    |  Use the following format:                           |
    |   Members: FM DH KC                                  |
    | (for Freedie Mercury, Debbie Harry and Kurt Cobain)  |
    +------------------------------------------------------+
    "

    while true
    do
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
    
    
    #when more than 3 inputs (three or more inputs)
    elif [ ! -z "$memb4" ] 
    then
        #error message
        echo "
    +----------+--------------------------------+
    | ERROR!!! |       ┐(T w T)┌                |
    +----------+--------------------------------|
    |   Please enter only three band members    |
    |   try again   ~(T 3 T)~	                |
    +-------------------------------------------+
        "

    #when less than 3 correct member code (members repeating)
    elif [ $totalFound -lt 3 -a $totalFound -gt 0 ]
    then
    #error message
        echo "
    +----------+--------------------------------------+
    | ERROR!!! |       ┐(T w T)┌                      |
    +----------+--------------------------------------|
    |  Please enter code of 3 different band members  |
    |  try again  \(O w O)/                           |
    +-------------------------------------------------+
        "
        continue

    #when 0 member codes are correct (invalid codes)
    else
    #error message
    echo "
    +----------+----------------------------------------------------+
    | ERROR!!! |         ┐(T w T)┌                                  |
    +----------+----------------------------------------------------|
    | Please use the given codes to select band members!! (T w T)   |
    +---------------------------------------------------------------+
    "
        continue
    fi
    done
}

#Transition between function callings (for asthetics)
transition() {
sleep 0.5
echo -n "Loading next segment: ";sleep 0.5
echo -n "##"; sleep 0.5
echo -n "##"; sleep 0.5
echo -n "###"; sleep 0.5
echo -n "#"; sleep 0.5
echo -n "#"; sleep 0.5
echo -n "#"; sleep 0.5
echo -e "\n\n"
}

#faking loading for transition (for asthetics)
loading() {
    sleep 1
    echo -n .
    sleep 1 
    echo -n .
    sleep 1 
    echo -n .
    sleep 1 
    echo -en ."\n"
}

#Choose one member to view info
chooseOneMember() {
    PS3="Enter one of the three Band member code: "
    select member in $1 $2 $3
    do 
        if [ -z $member ]
        then
            echo "
    +----------+-----------------------------+
    | ERROR!!! |       ┐( ^ w ^)┌            |
    +----------+-----------------------------|
    | Please select from one of the option   |
    | Using the respective numbers (1,2,3)   |
    +----------------------------------------+
            "
        else
            echo -en "\n\nYou've selected $member, Displaying $member file"
            loading

            #error message for non existing files
            if [ "$member" == "DH" ] || [ "$member" == "KC" ] 
            then
                echo "
    +----------+--------------------------------+
    | ALERT!!! |         ┐(T w T)┌              |
    +----------+--------------------------------|
    | File on this band member is unavailable   |
    +-------------------------------------------+
                "
                echo -n "Taking user back to Band selection step"
                #calling fake loading function for transition delay
                loading

                #returning to mainfunction
                mainFunction
                
                #to exit the select loop
                break
            else
                #reading the member file
                cat $member;

                #Ask the user for program continuity using function
                continueOrNot

                #exiting the select loop
                break
            fi
        fi
    done
}

#Best band determination logic
bestBandGuess() {
    bestBandCorrect=false

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

    #Guessing best band till correct band is selected
    until [ $bestBandCorrect == true ] 
    do
    
    #Taking band code input
    read -p "your guess: " bestBand; echo

    #Checking the guess
    case $bestBand in
        #correct band code and answer
        QUE)
            echo "
    +====================================================+
    | YES!! QUEEN is the best band!      \(^ w ^)/       |
    |                                                    |
    | Queen was a popular british rock band of the 70s.  |
    | they popularized glam rock and encorperated genres |
    | ranging from heavy metal to subtle jazz            |
    +====================================================+
            "
            #changing best band correct status to true
            bestBandCorrect=true
        ;;
        
        #correct band code but incorrect answer
        NIR | BEA | BLO | AD)
            echo "
    +----------+----------------------------------+
    | ALERT!!! |         ┐(^ w ^)┌                |
    +----------+----------------------------------|
    | They are a good band, but not the best one  |
    | Guess again!!  ~(^ W ^)~                    |
    +---------------------------------------------+
            "
            echo
        ;;

        #incorrect band code
        *)
            echo "
    +----------+--------------------------------+
    | ERROR!!! |       ┐( T w T)┌               |
    +----------+--------------------------------|
    | Plesase use the appropirate CODE assigned |
    | to the respective bands and try again!    |
    |                                           |
    | Example: BEA (for Beatles)                |
    +-------------------------------------------+
            "
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
    #transition delay
    sleep 2
    #Continue or not message
    echo "
    +======================================================+
    |  Do you want to continue this program?!  (T w T)     |
    |                                                      |
    |  [ yes | no ] options available	                   |
    |                                                      |
    +======================================================+
    "
    #taking user input
    read -p "select option: " contd
}

#Main program
mainFunction() {
    while true
    do
        #default program continue status
        contd="yes"

        #Best band guessing
        bestBandGuess 
        #adding transition delay
        transition

        #default 3 selected band
        member1=""
        member2=""
        member3=""

        #Selecting 3 star band members out of five
        selectBandMembers

        #Choose 1 member to display information
        chooseOneMember $member1 $member2 $member3
        
        #program continuity
        #dont continue the program
        if [ "$contd" == "no" ] 
        then
            break
        
        #continue program
        elif [ "$contd" == "yes" ]
        then
            clear
            continue

        #error continue option (make user choose again)
        else 
            echo "
    +----------+--------------------------+
    | ALERT!!! |      ┐(^ w ^)┌           |
    +----------+--------------------------|
    | only 'yes' and 'no' are allowed     |
    +-------------------------------------+
            "
            continueOrNot
        fi
    done   
}

#seperate end section function
endSection (){
    #end note
        echo "
    +==============================================+
    |  This program ends here  \(^ w ^)/           |
    |                                              |
    |  Thank you for your time, have a nice day!!  |
    |                                              |
    +==============================================+
    " 
}

superFunction (){
    #calling main function
    mainFunction

    #to display end note
    endSection
}

#password checking
passwordCheck (){
    counter=0
    password=password123

    for chance in 3 2 1 
    do 
        echo "Enter the program password ( $chance remaining ):"
        read -s check 
        if [ "$check" == $password ] 
        then
            #greet the user first
            greetings
            #call main program
            superFunction
            break
        fi
        #count incrementation
        ((counter++))

        #check no of attempts
        if [ $counter == 3 ] 
        then

        #no of attempts exceeded terminating the program
        echo '
    +==========================================+
    |  Your chance ends   ┐(^ W ^ )┌	       |
    |                                          |
    |  Try again with correct password!        |
    |                                          |
    +==========================================+
        '
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
        echo "
    +----------+-----------------------------------------+
    | ERROR!!! |       ┗(╬T _ T)┓                        |
    +----------+-----------------------------------------|
    | This program accepts ID and Name parameters ONLY!! |
    +----------------------------------------------------+
        "
    fi
else
    echo "
    +----------+-----------------------------------+
    | ERROR!!! |       ┗(T o T)┓                   |
    +----------+-----------------------------------|
    | This program accepts ID and Name parameter   |
    +----------------------------------------------+
    "
fi
