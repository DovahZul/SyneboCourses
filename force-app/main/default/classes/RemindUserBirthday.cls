global class RemindUserBirthday implements Schedulable {



    global void execute(SchedulableContext context){

            List<Contact> birthdays =  [SELECT Name, Birthdate
            FROM Contact
            WHERE Birthdate >= TODAY];
            Util.remindBirthdays(birthdays);
    }


}
