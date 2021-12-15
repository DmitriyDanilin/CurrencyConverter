/**
 * Created by DmytroDanilin on 15.12.2021.
 */

public with sharing class DependencyInjector {
    public static Object inject(Type interfaceType){
        Type classType = Type.forName(getMappedClassName(interfaceType));
        return classType.newInstance();
    }

    private static String getMappedClassName(Type interfaceType){
        DependencyInjection__mdt dependencyInjection = [SELECT Id, DeveloperName, InterfaceName__c, MappedClass__c
        FROM DependencyInjection__mdt WHERE InterfaceName__c =:interfaceType.toString()];
        return dependencyInjection.MappedClass__c;
    }

}