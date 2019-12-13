/**
* Fanalca
* @author 			?
* Description:		Task trigger to manage all events.
*
* Changes (Version)
* -------------------------------------
*			No.		Date			Author					Description
*			-----	----------		--------------------	---------------
* @version	1.0		06/02/2018		?						Trigger creation.
* @version	2.0		03/12/2018		Raul Mora (RM)			Trigger refactor.
* @version	2.1		13/12/2019		Andrés Oiva (AO 		Call method updateAccountRelation
*********************************************************************************************************/
trigger UpdateField2 on Task (before insert,before update ) 
{
    //03/12/2018 RM. Trigger refactor. 
    if( Trigger.isBefore && Trigger.isInsert ) {
        RM_TaskTriggerHandler_cls.taskBeforeInsert( Trigger.new );
        RM_TaskTriggerHandler_cls.updateAccountRelation( trigger.New,null );
    }
    if( trigger.IsBefore && trigger.isUpdate ){
        RM_TaskTriggerHandler_cls.updateAccountRelation( trigger.New,trigger.OldMap );
    }
}