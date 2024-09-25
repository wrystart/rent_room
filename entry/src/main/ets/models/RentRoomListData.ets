import { IRoomRecommendItem } from './HomeData'

export interface ISearchRoomListParams {
  page: number
  limit: number
  provinceCode?: number
  cityCode?: number
  districtCode?: number
  minRent?: number
  maxRent?: number
  paymentType?: string
  orderBy?: string
  orderType?: string
}

export interface IActivity {
  "title": string,
  "textColor": string,
  "textBackGroundColor": string,
  "#text": string,
  "icon": string
}

export interface IRoomItem extends IRoomRecommendItem {
  activity: IActivity
}

export type IRoomList = IRoomItem[]

export interface ISearchRoomListData {
  records: IRoomList
  total: string
}