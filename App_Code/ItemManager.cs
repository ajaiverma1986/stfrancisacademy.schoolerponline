using itemmanager;
using System;
using System.Collections.Generic;
using System.Xml;

/// <summary>
/// Summary description for ItemManager
/// </summary>
public class ItemManager
{
    public int SaveRightInformation(List<itemRight> ListRight)
    {
        int returnValue = 0;
        try
        {
            savestudentitem objMenuRightAccess = new savestudentitem();
            returnValue = objMenuRightAccess.SaveRightInformation(BuildRightXml(ListRight));
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return returnValue;
    }

    private string BuildRightXml(List<itemRight> ListRight)
    {
        if (ListRight == null)
            return "";
        XmlDocument objectXmlDocument = new XmlDocument();
        XmlElement RightElement = objectXmlDocument.CreateElement("Right");
        for (int i = 0; i < ListRight.Count; i++)
        {
            try
            {
                RightElement.AppendChild(BuildRightHeadXml((itemRight)ListRight[i], objectXmlDocument));
            }
            catch (Exception objectException)
            {
                throw objectException;
            }
        }
        objectXmlDocument.AppendChild(RightElement);
        return objectXmlDocument.OuterXml;
    }

    private static XmlElement BuildRightHeadXml(itemRight objRight, XmlDocument objectXmlDocument)
    {
        XmlElement RightElement = objectXmlDocument.CreateElement("Right");
        RightElement.SetAttribute("StudentID", Convert.ToString(objRight.studenttID));
        RightElement.SetAttribute("Itemid", Convert.ToString(objRight.ItemID));
        RightElement.SetAttribute("Status", Convert.ToString(objRight.status));
        return RightElement;
    }
}