public with sharing class cotizaciontriggerHandlerAfterInsert 
{
    /*Method : create task
     * Input : list< AM_Oportunidad__c >
     * output : list< task >
    */

    public static void updateCategiaNegocio( list< AM_Oportunidad__c > lstNewCotizacion  )
    {
        map< id, AM_Oportunidad__c >   mapCotizacion     =   new map< id, AM_Oportunidad__c >  ();
        list< task > lstTaskUpdate  = new list< task >();
        for( AM_Oportunidad__c varCotz: lstNewCotizacion )
        {
            mapCotizacion.put( varCotz.Id, varCotz ); 
        }
        list< task > lstTaskToUpdate    = [ SELECT  id, 
                                                    WhatId,
                                                    AM_Categoria_de_Negocio_1__c 
                                            FROM    TASK
                                            WHERE   WhatId IN: mapCotizacion.KeySet() 
                                                    AND AM_Categoria_de_Negocio_1__c = null ];
        for(task varTask : lstTaskToUpdate )
        {
            if( varTask.WhatId != null  && mapCotizacion.containsKey( varTask.WhatId ))
            {
                varTask.AM_Categoria_de_Negocio_1__c    =   mapCotizacion.get( varTask.WhatId ).AM_Etapa__c; 
                lstTaskUpdate.add( varTask );
            }
        }
        update lstTaskUpdate ;
    }
    
    /*Method : create task
     * Input : list< AM_Oportunidad__c >
     * output : list< task >
    */


    
    public static list< task > createTask ( list< AM_Oportunidad__c > lstNewCotizacion )
    {
        
        list< task > lstTask    =   new     list< task >();
        Id recordTypeId =   Schema.SObjectType.AM_Oportunidad__c.getRecordTypeInfosByDeveloperName().get('AM_Presupuesto').getRecordTypeId();    
    
        for( AM_Oportunidad__c varCot: lstNewCotizacion )
        { 
                if( varCot.recorDtypeId != recordTypeId )
                {
                    system.debug('\n cotizacion@@@ ' + varCot + '\n person account'+  varCot.AM_Usuario_motocicleta__r.PersonContactId );
                    task  varTask                       =   new task ();
                    varTask.WhoId                       =   varCot.AM_Usuario_motocicleta__r.PersonContactId; 
                    varTask.whatId                      =   varCot.id;
                    varTask.Description                 =   system.Label.AO_descripcionTareaSeguimiento_lbl; //Comunicarse con el cliente para continuar con el proceso de venta y aclarar inquietudes sobre el automóvil.
                    varTask.Subject                     =   system.label.AO_subjectActividadSeguimt_lbl;    // Realizar actividad de seguimiento
                    varTask.Status                      =   system.label.AO_statusProgramada_lbl;   //Programada
                    varTask.Priority                    =   system.label.AO_priorityNormal_lbl;     //Normal                    
                    varTask.ActivityDate                =   varCot.AM_Fecha_de_vigencia__c;
                    //varTask.AM_Traer_informacion_Cotizaci_n__c = varCot.Id;
                    varTask.AM_Categoria_de_Negocio_1__c =  varCot.AM_Etapa__c; 
                   // varTask.AM_Otro_TelefonoL__c        =   varCot.;
                    lstTask.add( varTask );
                  // varTask.AM_Modelo_de_interesL__c  =   varCot.AM_Traer_informacion_Cotizaci_n__r ; //--FORMULA
                    //varTask.AM_Telefono_Light__c      =   varCot.
                    //varTask.AM_Correo_electronicoL__c     =   varCot. 
                }
                
        }           
        System.debug('\n regsitros a insertar @@@' +  lstTask );
        insert lstTask ;
        return lstTask ;
    
    }


}