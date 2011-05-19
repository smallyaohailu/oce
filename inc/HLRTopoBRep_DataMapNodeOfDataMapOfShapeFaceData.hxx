// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData_HeaderFile
#define _HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData_HeaderFile

#ifndef _Standard_HeaderFile
#include <Standard.hxx>
#endif
#ifndef _Standard_DefineHandle_HeaderFile
#include <Standard_DefineHandle.hxx>
#endif
#ifndef _Handle_HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData_HeaderFile
#include <Handle_HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData.hxx>
#endif

#ifndef _TopoDS_Shape_HeaderFile
#include <TopoDS_Shape.hxx>
#endif
#ifndef _HLRTopoBRep_FaceData_HeaderFile
#include <HLRTopoBRep_FaceData.hxx>
#endif
#ifndef _TCollection_MapNode_HeaderFile
#include <TCollection_MapNode.hxx>
#endif
#ifndef _TCollection_MapNodePtr_HeaderFile
#include <TCollection_MapNodePtr.hxx>
#endif
class TopoDS_Shape;
class HLRTopoBRep_FaceData;
class TopTools_ShapeMapHasher;
class HLRTopoBRep_DataMapOfShapeFaceData;
class HLRTopoBRep_DataMapIteratorOfDataMapOfShapeFaceData;



class HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData : public TCollection_MapNode {

public:

  
      HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData(const TopoDS_Shape& K,const HLRTopoBRep_FaceData& I,const TCollection_MapNodePtr& n);
  
        TopoDS_Shape& Key() const;
  
        HLRTopoBRep_FaceData& Value() const;




  DEFINE_STANDARD_RTTI(HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData)

protected:




private: 


TopoDS_Shape myKey;
HLRTopoBRep_FaceData myValue;


};

#define TheKey TopoDS_Shape
#define TheKey_hxx <TopoDS_Shape.hxx>
#define TheItem HLRTopoBRep_FaceData
#define TheItem_hxx <HLRTopoBRep_FaceData.hxx>
#define Hasher TopTools_ShapeMapHasher
#define Hasher_hxx <TopTools_ShapeMapHasher.hxx>
#define TCollection_DataMapNode HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData
#define TCollection_DataMapNode_hxx <HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData.hxx>
#define TCollection_DataMapIterator HLRTopoBRep_DataMapIteratorOfDataMapOfShapeFaceData
#define TCollection_DataMapIterator_hxx <HLRTopoBRep_DataMapIteratorOfDataMapOfShapeFaceData.hxx>
#define Handle_TCollection_DataMapNode Handle_HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData
#define TCollection_DataMapNode_Type_() HLRTopoBRep_DataMapNodeOfDataMapOfShapeFaceData_Type_()
#define TCollection_DataMap HLRTopoBRep_DataMapOfShapeFaceData
#define TCollection_DataMap_hxx <HLRTopoBRep_DataMapOfShapeFaceData.hxx>

#include <TCollection_DataMapNode.lxx>

#undef TheKey
#undef TheKey_hxx
#undef TheItem
#undef TheItem_hxx
#undef Hasher
#undef Hasher_hxx
#undef TCollection_DataMapNode
#undef TCollection_DataMapNode_hxx
#undef TCollection_DataMapIterator
#undef TCollection_DataMapIterator_hxx
#undef Handle_TCollection_DataMapNode
#undef TCollection_DataMapNode_Type_
#undef TCollection_DataMap
#undef TCollection_DataMap_hxx


// other Inline functions and methods (like "C++: function call" methods)


#endif