import json 
import datetime
import pandas as pd

def info3(path:str):
    """
    This function takes a path to a json file from google maps datas and return some lists with positions and times

    Parameters
    ----------
    path : string
        path to the json file

    Returns
    -------
    start_lat : list
        list of start latitude
    start_long : list
        list of start longitude
    end_lat : list
        list of end latitude
    end_long : list
        list of end longitude
    times : list
        list of times

    """

    start_long=[]
    end_long=[]
    start_lat=[]
    end_lat=[]
    time=[]
    with open(path) as json_data:
        data_dict = json.load(json_data)

    for index in range(len(data_dict['timelineObjects'])) : 
        if 'activitySegment' in data_dict['timelineObjects'][index].keys() : 
            time_start=(data_dict['timelineObjects'][index]["activitySegment"]["duration"]["startTimestampMs"])
            time_end = (data_dict['timelineObjects'][index]["activitySegment"]["duration"]["endTimestampMs"])
            time.append((int(time_start) + int(time_end))/2)
            start_lat.append(data_dict['timelineObjects'][index]["activitySegment"]["startLocation"]["latitudeE7"]*0.0000001)
            start_long.append(data_dict['timelineObjects'][index]["activitySegment"]["startLocation"]["longitudeE7"]*0.0000001)
            end_long.append(data_dict['timelineObjects'][index]["activitySegment"]["endLocation"]["longitudeE7"]*0.0000001)
            end_lat.append(data_dict['timelineObjects'][index]["activitySegment"]["endLocation"]["latitudeE7"]*0.0000001)
    return start_lat, start_long,end_long, end_lat, time

def get_all_data(path:str):  
    """
    This function takes a path to a json file from google maps datas. 
    The function create a data file into csv and return a dataframe with the informations

    Parameters
    ----------
    path : string
        path to the json file
    
    Returns
    -------
    df : dataframe
        dataframe with the informations
    
    """
    a,b,c,d,e = info3(path)

    dates_l=[]
    for i in e : 
        date=datetime.datetime.fromtimestamp(int(i) / 1000.0, tz=datetime.timezone.utc)
        date=str(date)
        dates_l.append(date[8:])
    df2=pd.DataFrame(list(zip(dates_l,a,b,c,d)),columns=["time","start_lat","start_long","end_long","end_lat"])
    df2.to_csv('data.csv')
    return df2