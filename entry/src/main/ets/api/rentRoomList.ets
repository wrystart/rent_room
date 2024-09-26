import { http } from '../utils/http';
import type {
  ICityList,
  IDistrictList,
  IProvinceList,
  ISearchRoomListData,
  ISearchRoomListParams
} from '../models/RentRoomListData';

// 搜索房源列表数据
export const searchRoomListApi = (params: ISearchRoomListParams): Promise<ISearchRoomListData> => {
  return http.get<ISearchRoomListData>('/house/search', params)
}

// 获取省份数据
export const getProvinceListApi = (): Promise<IProvinceList> => {
  return http.get<IProvinceList>('/province')
}

// 获取城市数据
export const getCityListApi = (provinceCode: string): Promise<ICityList> => {
  return http.get<ICityList>('/city', { provinceCode })
}

// 获取区县数据
export const getDistrictListApi = (cityCode: string): Promise<IDistrictList> => {
  return http.get<IDistrictList>('/area', { cityCode })
}