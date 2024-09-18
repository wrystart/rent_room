export interface IHomeData {
  "bannerList": IBannerList,
  "navList": INavList,
  "tileList": ITileList,
  "planList": IPlanList,
  "adPicture": string
}

export interface IBannerItem {
  "id": number,
  "name": string,
  "imageURL": string
}

export type IBannerList = IBannerItem[]

export interface INavItem {
  "id": number,
  "title": string,
  "imageURL": string
}

export type INavList = INavItem[]

export interface ITitleItem {
  "id": number,
  "imageURL": string,
  "title": string,
  "sub_title": string
}

export type ITileList = ITitleItem[]

export interface IPlanItem {
  "id": number,
  "imageURL": string
}

export type IPlanList = IPlanItem[]

