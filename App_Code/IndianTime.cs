using System;

/// <summary>
/// Summary description for IndianTime
/// </summary>
public class IndianTime
{
    public static DateTime GetIndianTime()
    {
        return DateTime.UtcNow.AddMinutes(330);
    }
}