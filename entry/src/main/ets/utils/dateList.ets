import { IFormatDate, IFormatDateList } from '../models/RentRoomDetailData';

const DAY_TIME = 1000 * 3600 * 24;


function formatDate(time: number) {
  const date = new Date(time);
  const year = date.getFullYear();
  const month = addZero(date.getMonth() + 1);
  const day = addZero(date.getDate());
  const week = formatWeekText(date.getDay());
  const formatDate: IFormatDate = {
    week,
    date: `${year}-${month}-${day}`,
  }
  return formatDate
}

function formatWeekText(week: number) {
  switch (week) {
    case 0:
      return '周日'
    case 1:
      return '周一'
    case 2:
      return '周二'
    case 3:
      return '周三'
    case 4:
      return '周四'
    case 5:
      return '周五'
    default:
      return '周六'
  }
}

function addZero(val: number) {
  return val < 10 ? '0' + val : `${val}`;
}

export default function createDateList() {
  const nowTime = Date.now();
  const oneDayTime = 24 * 3600 * 1000;
  const dateList: IFormatDateList = [];
  for (let i = 0; i < 7; i++) {
    const date = formatDate(nowTime + i * oneDayTime)
    if (i === 0) {
      date.week = '今天'
    }
    dateList.push(date)
  }
  return dateList
}





