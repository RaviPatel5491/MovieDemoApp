//
//  DatabaseManager.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit
import FMDB

class DatabaseManager {
    
    static let shared = DatabaseManager()
    var database = FMDatabase()

    //database init
    init() {
        createDB()
    }
    func createDB()
    {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DATABASE_NAME)
        database = FMDatabase(path: fileURL.path)
        
        
        print(fileURL)
        if !database.open()
        {
            print("Unable to open database")
            return
        }
        do {
            try database.executeUpdate(CREATE_SEARCH_TABLE, values: nil)
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
    }
    func dbPath()->String
    {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(DATABASE_NAME)
        
        return fileURL.path
    }
    
    func addTextToSearch(text:String)
    {
        let objSearch = Search()
        objSearch.text = text
        objSearch.timestamp = AppUtility.currentMiliSecond()
        
        self.insertOrUpdateTable(objSearch.dictionaryRepresentationTable() as! NSMutableDictionary, condition: " Where \(T_SEARCH_TEXT) = '\(text)'", tableName: T_SEARCH as NSString)
    }
    func deleteTextFromDB(rowId:Int)
    {
        deleteCondition(condition: " \(T_SEARCH_ID) = \(rowId)", tableName: T_SEARCH as NSString)
    }
    
    
    ///  basic queries
    func deleteCondition(condition : String, tableName :NSString)
    {
        let objDatabase = FMDatabase(path: dbPath())
        
        if (objDatabase.open())
        {
            
            do
            {
                let query = "DELETE FROM \(tableName)  WHERE "+condition
                
                try objDatabase.executeUpdate(query, values:[nil ?? NSNull()])
                
            }
            catch
            {
                print("error = \(error)")
            }
            objDatabase.close()
        }
        
    }
    
    func insertOrUpdateTable(_ dictionary : NSMutableDictionary , condition : String, tableName :NSString)
    {
        let keyWordsFound =  self.getTableData(tableName, condition: condition as NSString)
        
        if keyWordsFound.count == 0
        {
            self.insertTable(dictionary, condition: condition, tableName: tableName)
        }
        else
        {
            if let val = dictionary.value(forKey: T_SEARCH_TEXT) as Optional
            {
                dictionary.removeObject(forKey: T_SEARCH_TEXT)
                dictionary.setValue(AppUtility.currentMiliSecond(), forKey: T_SEARCH_TS)
                self.updateTable(dictionary, condition: "\(T_SEARCH_TEXT) = '\(val)'", tableName: tableName)
            }
        }
    }
    func insertTable(_ dictionary : NSMutableDictionary , condition : String, tableName :NSString)
    {
        
        let objDatabase = FMDatabase(path: dbPath())
        
        if (objDatabase.open())
        {
            do {
                var strquery = "INSERT INTO " + (tableName as String) + " (" as String
                
                var count = 0
                for stringkey in dictionary.allKeys
                {
                    let strtoadd =  stringkey as! String
                    strquery =  strquery + "\"" + (strtoadd) + "\""
                    if count != dictionary.allValues.count - 1
                    {
                        strquery = strquery + ","
                    }
                    count += 1
                }
                
                count = 0
                
                strquery = strquery + ") VALUES ("
                
                for stringval in dictionary.allValues
                {
                    let strtoadd =  String(describing: stringval)
                    strquery =  strquery + "\"" + (strtoadd) + "\""
                    if count != dictionary.allValues.count - 1
                    {
                        strquery = strquery + ","
                    }
                    count += 1
                }
                strquery = strquery + ")"
                
                
                
                //            print(strquery)
                
                try objDatabase.executeUpdate(strquery,values:[NSNull()])
                
            } catch
            {
                print("failed in insert \(tableName): \(error)")
            }
            
            objDatabase.close()
        }
    }
    func getTableData(_ Table : NSString,condition : NSString) -> NSMutableArray
    {
        let objDatabase = FMDatabase(path: dbPath())
        let ArrayToReturn = NSMutableArray()
        
        if (objDatabase.open())
        {
            
            do {
                var query = "SELECT * FROM " + (Table as String)
                
                
                if condition==""
                {
                    
                }
                else
                {
                    query = "SELECT * FROM "+(Table as String) + (condition as String)
                }
                
                let rs = try objDatabase.executeQuery(query, values: nil)
                
                while (rs.next())
                {
                    ArrayToReturn.add(rs.resultDictionary!)
                }
            } catch let error as NSError
            {
                
                print("failed in gettable \(Table): \(error.localizedFailureReason)")
            }
            //            objDatabase?.commit()
        }
        
        return ArrayToReturn
    }
    func updateTable(_ dictionary : NSMutableDictionary , condition : String, tableName :NSString)
    {
        let objDatabase = FMDatabase(path: dbPath())
        
        if (objDatabase.open())
        {
            var strquery = ""
            do {
                strquery = "UPDATE \(tableName) SET "
                
                var count = 0
                for stringkey in dictionary.allKeys
                {
                    let strtoadd =  stringkey as! String
                    strquery = strquery + "\(strtoadd) = \"\(dictionary[strtoadd]!)\""
                    if count != dictionary.allValues.count - 1
                    {
                        strquery = strquery + ","
                    }
                    count += 1
                }
                
                strquery = strquery + " WHERE "+condition
                
                // print(strquery)
                
                try objDatabase.executeUpdate(strquery,values:[NSNull()])
                
            } catch
            {
                print("error = \(error)")
                print("failed in update \(strquery): \(error.localizedDescription)")
                
            }
            objDatabase.close()
        }
        
    }
}
