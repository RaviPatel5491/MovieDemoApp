//
//  Constants.swift
//  MovieDemo
//
//  Created by Jigar Patel on 07/01/19.
//  Copyright © 2019 Brainybeam. All rights reserved.
//

import UIKit

// Whole app constants defined here
let DATABASE_NAME = "SEARCH.DB"
let colorPrimary = UIColor(hexString: "#0d1a3a")
let colorPrimaryDark = UIColor(hexString: "#000016")
let colorAccent = UIColor(hexString: "#384065")

// API urls
let HOMEURL = "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp/home"
let SEARCH_URL = "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp/search?"

// Other String Constants
let SOMETHING_WENT_WRONG = "Something went wrong!"
let DATE_FORMAT = "dd MMM yyyy"
let INTERNET_FAILURE_MESSAGE = "Please Check Your Internet Connection!"
let RESPONCE_CODE = "Responce_code"
let PROGRESS_GETTINGMOVIES = "Getting Movies..."
let RESPONSE_RESULT = "results"
let CATEGORY_SHOWING = "showing"
let CATEGORY_UPCOMING = "upcoming"
let SEARCH_PLACEHOLDER = "Search Movie"
let SEARCH_ALERT = "Please enter valid search text"
let NOW_SHOWING = "Now Showing"
let Coming_SOON = "Coming Soon"

// Movie Data String Constants
let MOVIE_POSTER_PATH = "poster_path"
let MOVIE_RATE = "rate"
let MOVIE_ID = "id"
let MOVIE_RELEASE_DATE = "release_date"
let MOVIE_TITLE = "title"
let MOVIE_PRESALE_FLAG = "presale_flag"
let MOVIE_AGE_CATEGORY = "age_category"
let MOVIE_DESCRIPTION = "description"
let MOVIE_GENRE_ID = "genre_ids"

// Genre IDs String Constants

let GENRE_IDS_ID = "id"
let GENRE_IDS_NAME = "name"


//Database Search table fields
let T_SEARCH = "tSearch";
let T_SEARCH_ID = "rowid";
let T_SEARCH_TEXT = "Text";
let T_SEARCH_TS = "Timestamp";

var CREATE_SEARCH_TABLE = "CREATE TABLE " + T_SEARCH + "(" +
    T_SEARCH_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
    T_SEARCH_TS + " TEXT," +
    T_SEARCH_TEXT + " INTEGER" + ")"

class Constants
{
    
}

