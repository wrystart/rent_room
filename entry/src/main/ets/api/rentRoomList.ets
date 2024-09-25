import { http } from '../utils/http';
import type { ISearchRoomListData, ISearchRoomListParams } from '../models/RentRoomListData';

// 搜索房源列表数据
export const searchRoomListApi = (params: ISearchRoomListParams): Promise<ISearchRoomListData> => {
  return http.get<ISearchRoomListData>('/house/search', params)
}